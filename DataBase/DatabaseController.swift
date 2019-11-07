//
//  DatabaseController.swift
//  OnboardingLottie
//
//  Created by Ganesh Kanchibhotla on 7/11/19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore





class FirebaseController: NSObject, DatabaseProtocol {
    
    
    var listeners = MulticastDelegate<DatabaseListener>()
    var authController: Auth
    var database: Firestore
    var sensorRef: CollectionReference?
    var teamsRef: CollectionReference?
    var dataList: [Sensor]
    var tempList: [Sensor]
    
    override init(){
        FirebaseApp.configure()
        authController = Auth.auth()
        database = Firestore.firestore()
        dataList = [Sensor]()
        tempList = [Sensor]()
        
        super.init()
        authController.signInAnonymously() { (authResult, error) in
            guard authResult != nil else {
                fatalError("Firebase authentication failed")
            }
            self.setUpListeners()
        }
    }
    
    func setUpListeners() {
        
        sensorRef = database.collection("Sensors")
        sensorRef?.addSnapshotListener { querySnapshot, error in
            guard (querySnapshot?.documents) != nil else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.parseSensorsSnapshot(snapshot: querySnapshot!)
        }
    }
    
    
    func parseSensorsSnapshot(snapshot: QuerySnapshot){
    
        
        snapshot.documentChanges.forEach { change in
        
            let data = change.document.data()
            
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                let xyz = try JSONDecoder().decode(Sensor.self , from: jsonData)
                tempList.append(xyz)
                print(change.document.documentID, xyz.timestamp)
            }
            catch {
                print(error.localizedDescription)
                return
            }

        }
        
        tempList = tempList.sorted(by: { $0.timestamp > $1.timestamp })
        dataList = [Sensor]()
        dataList.append(tempList[0])
        dataList.append(tempList[1])
        
        listeners.invoke { (listener) in
            if listener.listenerType == ListenerType.data || listener.listenerType == ListenerType.all {
                listener.onDataListChange(change: .update, dataList: dataList)
            }
        }

    }
    
    func addListener(listener: DatabaseListener) {
        
        listeners.addDelegate(listener)
        if listener.listenerType == ListenerType.data || listener.listenerType == ListenerType.all {
            listener.onDataListChange(change: .update, dataList: dataList)
        }
        
    }
    
    func removeListener(listener: DatabaseListener) {
        
        listeners.removeDelegate(listener)
        
    }

}
