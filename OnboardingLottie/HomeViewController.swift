//
//  HomeViewController.swift
//  OnboardingLottie
//
//  Created by Sai Raghu Varma Kallepalli on 4/11/19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import UIKit
import Lottie
import AVFoundation
import LocalAuthentication

//created new class for parsing speed

class HomeViewController: UIViewController, DatabaseListener {
    
    @IBOutlet weak var lockStatusLabel: UILabel!
    @IBOutlet weak var carAddress: UILabel!
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var userStatus: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var blackBg: UIImageView!
    @IBOutlet weak var popBtn: UIButton!
    
    var lockStatus: Bool = true
    var userLogin: Bool = false
    var context = LAContext()
    var error: NSError?
    
    var soundAlert = Bundle.main.path(forResource: "", ofType: "mp3")
    var audioPlayer: AVAudioPlayer!
    var imageView = UIImageView()
    var animationView = LAAnimationView.animationNamed("")
    
    weak var databaseController: DatabaseProtocol?
    var dataList: [Sensor] = [Sensor]()

    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        animation(y: -330)
        self.startAnimations()
        self.enableImageTapping()
        self.applyMotionEffect(toView: self.userProfilePic, magnitude: -15)
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate!.databaseController
    }
    
    var listenerType = ListenerType.data

    func onDataListChange(change: DatabaseChange, dataList: [Sensor]) {
        self.dataList = dataList
        if(!dataList.isEmpty){
            //updateCarLocation(latitude: dataList[0].gps.curLat, longitude: dataList[0].gps.curLong)
            self.userName.text = dataList[0].rfid.name
            isCarMoving()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        databaseController?.addListener(listener: self)
    }
       
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        databaseController?.removeListener(listener: self)
    }
    
    func animation(y: CGFloat) {
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            UIView.animate(withDuration: 3, animations: {
                self.userStatus.transform = CGAffineTransform(translationX: 0, y: y)
                self.userName.transform = CGAffineTransform(translationX: 0, y: y)
                self.userProfilePic.transform = CGAffineTransform(translationX: 0, y: y)
                self.blackBg.transform = CGAffineTransform(translationX: 0, y: y)
                self.blackBg.layer.cornerRadius = (self.blackBg.frame.size.width)/10
                self.blackBg.clipsToBounds = true
                
            })
        }
        
    }
    
    func enableImageTapping() {
        imageView  = UIImageView(frame:CGRect(x: 0, y: 300, width: self.view.frame.size.width, height: 100));
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named:"")
        self.view.addSubview(imageView)
        let singleTap = UITapGestureRecognizer(target: self,action:Selector(("imageTapped")))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(singleTap)
    }
    
    func playSound(name: String) {
        soundAlert = Bundle.main.path(forResource: name, ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundAlert!))
            audioPlayer.play()
        } catch {
            print("couldn't load sound file")
        }
    }
    
    @IBAction func lockBtn(_ sender: UIButton) {
        if lockStatus {
            if userLogin {
                if #available(iOS 13.0, *) {
                    UIView.animate(withDuration: 1, animations: {
                        sender.setBackgroundImage(UIImage(systemName: "lock.open"), for: .normal)
                        self.lockStatus.toggle()
                        self.playSound(name: "unlock")
                        self.lockStatusLabel.text = "Unlocked"
                        sender.transform = CGAffineTransform(translationX: 10, y: 0)
                    })
                }
            }
            else {
                FaceId()
            }
        }
        else {
            if #available(iOS 13.0, *) {
                UIView.animate(withDuration: 1, animations: {
                    sender.setBackgroundImage(UIImage(systemName: "lock"), for: .normal)
                    self.lockStatus.toggle()
                    self.playSound(name: "lock")
                    self.lockStatusLabel.text = " Locked "
                    sender.transform = CGAffineTransform(translationX: -1, y: 0)
                })
                
            } else {
            }
        }
    }
    
    
    @objc func imageTapped() {
        playSound(name: "inside")
        performSegue(withIdentifier: "loadcar", sender: self)
    }
    
    func startAnimations() {
        
        //Notification bell
        loadLottie(fileName: "bell", x: 340, y: 50, width: 30, height: 30, loopStatus: false, enableTouch: true, magnitude: -10)
        //location arrow
        loadLottie(fileName: "arrow", x: Int(self.view.bounds.midX-85), y: Int(self.view.bounds.midY-57), width: 60, height: 60, loopStatus: true, enableTouch: false, magnitude: -5)
        loadLottie(fileName: "radar", x: 124, y: 60, width: 170, height: 170, loopStatus: false, enableTouch: false, magnitude: -10)
        //Moving car
        loadLottie(fileName: "bluecar", x: 0, y: 300, width: self.view.frame.size.width, height: 100, loopStatus: false, enableTouch: true, magnitude: 15)
        //tempLabelMenu.transform = CGAffineTransform(rotationAngle: -3.14/2)
        //Lock and Unlock button
        
        
        
    }
    
    func loadLottie(fileName: String, x: Int, y: Int, width: CGFloat, height: CGFloat, loopStatus: Bool, enableTouch: Bool, magnitude: Int)
    {
        animationView = LAAnimationView.animationNamed(fileName)
        animationView?.frame = CGRect(x: x, y: y, width: Int(width), height: Int(height))
        animationView?.contentMode = .scaleAspectFill
        animationView?.isUserInteractionEnabled = enableTouch
        animationView?.loopAnimation = loopStatus
        self.view.addSubview(animationView!)
        animationView?.play()
        applyMotionEffect(toView: animationView!, magnitude: Float(magnitude))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func applyMotionEffect (toView view: LAAnimationView, magnitude:Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(group)
    }
    
    func applyMotionEffect (toView view: UIImageView, magnitude:Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(group)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var b: Bool = false

    @IBAction func btn(_ sender: Any) {
        if b {
            animationView?.loopAnimation = true
            animationView?.play()
            b.toggle()
        }
        else {
            animationView?.pause()
            b.toggle()
        }
        
    }
    func FaceId()
    {
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Log in to your Profile"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                if success {
                    print("success faceid")
                    DispatchQueue.main.async {
                        self.userLogin.toggle()
                        //self.greetingLabel.text = "Raghu"
                    }
                }
                else {
                    DispatchQueue.main.async {
                        print(error?.localizedDescription ?? "Failed to authenticate")
                        //self.greetingLabel.text = error?.localizedDescription ?? "Failed to authenticate"
                    }
                    
                }
            }
        
        }
    }
    
    func updatecarLocation(latitude: Double, longitude: Double)
    {
        let lat = String(format: "%f", latitude)
        let lon = String(format: "%f", longitude)
        
        let url = URL(string: "https://reverse.geocoder.api.here.com/6.2/reversegeocode.json?prox=" + lat + "," + lon + ",50&mode=retrieveAddresses&locationAttributes=linkInfo&gen=9&app_id=bGsxRlcLJl9jlkPw8llT&app_code=P61HIba-X4DxDhv2SypcFg")
        
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            if let data = data {
                let resp = try? JSONDecoder().decode(JsonResponse.self, from: data)
                print("Location retrieved")
                DispatchQueue.main.async {
                    if((resp!.Response.View.first?.Result.first?.Location.Address.Street!.isEmpty)!){
                        self.carAddress.text = resp!.Response.View.first?.Result.first?.Location.Address.District
                    }
                    else{
                        print(resp!.Response.View.first?.Result.first?.Location.Address.Street)
                        self.carAddress.text = resp!.Response.View.first?.Result.first?.Location.Address.Street
                    }
                }
            }
        }.resume()
    }
    
    func isCarMoving(){
        
        if(dataList.count >= 2){
            
            let accelX1 = dataList[0].gyro.accelX
            let accelY1 = dataList[0].gyro.accelY
            let accelZ1 = dataList[0].gyro.accelZ
            let totalAccel1 = ((accelX1 * accelX1) + (accelY1 * accelY1) + (accelZ1 * accelZ1)).squareRoot()
            
            let accelX2 = dataList[1].gyro.accelX
            let accelY2 = dataList[1].gyro.accelY
            let accelZ2 = dataList[1].gyro.accelZ
            let totalAccel2 = ((accelX2 * accelX2) + (accelY2 * accelY2) + (accelZ2 * accelZ2)).squareRoot()
            
            let totalAccel: Double = totalAccel1 - totalAccel2
            
            if(totalAccel >= 2 || totalAccel <= -2)
            {
                animationView?.loopAnimation = true
                animationView?.play()
            }
            else{
                animationView?.pause()
            }
        }
        
        
    }
    
}
