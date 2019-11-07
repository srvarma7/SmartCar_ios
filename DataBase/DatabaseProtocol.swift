//
//  DatabaseProtocol.swift
//  OnboardingLottie
//
//  Created by Ganesh Kanchibhotla on 7/11/19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import Foundation

enum DatabaseChange {
    case add
    case remove
    case update
}

enum ListenerType {
    case data
    case all
}

protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onDataListChange(change: DatabaseChange, dataList: [Sensor])
}

protocol DatabaseProtocol: AnyObject {
    
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
