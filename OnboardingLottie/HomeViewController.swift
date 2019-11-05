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

struct JsonResponse: Codable {
    let Response: ResponseData
}

struct ResponseData: Codable {
    let View: [ViewData]
}

struct ViewData: Codable {
    let Result: [ResultData]
}

struct ResultData: Codable {
    let Location: LocationData
}

struct LocationData: Codable{
    let LinkInfo: LinkInfo
}

struct LinkInfo: Codable{
    let SpeedCategory: String
}

class HomeViewController: UIViewController {

     var lockStatus: Bool = true
    @IBOutlet weak var lockStatusLabel: UILabel!
    var soundAlert = Bundle.main.path(forResource: "", ofType: "mp3")
    var audioPlayer: AVAudioPlayer!
    
    var imageView = UIImageView()
    
    var lockAnimation = LAAnimationView()
    var animationView = LAAnimationView.animationNamed("")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimations()
        enableImageTapping()
        
//        //testing
//
//        loadLottie(fileName: "card", x: 0, y: 300, width: self.view.frame.size.width, height: 100, loopStatus: false, enableTouch: true)
//        loadLottie(fileName: "radar", x: 0, y: 300, width: self.view.frame.size.width, height: 100, loopStatus: false, enableTouch: true)
    }
    
    func enableImageTapping() {
        
        imageView  = UIImageView(frame:CGRect(x: 0, y: 300, width: self.view.frame.size.width, height: 100));
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named:"")
        self.view.addSubview(imageView)
        //applyMotionEffect(toView: imageView, magnitude: 50)
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
            if #available(iOS 13.0, *) { sender.setBackgroundImage(UIImage(systemName: "lock.open"), for: .normal)
                lockStatus.toggle()
                playSound(name: "unlock")
                lockStatusLabel.text = "Unlocked"
            } else {
                // Fallback on earlier versions
            }
        }
        else {
            if #available(iOS 13.0, *) { sender.setBackgroundImage(UIImage(systemName: "lock"), for: .normal)
                lockStatus.toggle()
                playSound(name: "lock")
                lockStatusLabel.text = " Locked "
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    @objc func imageTapped() {
        performSegue(withIdentifier: "loadcar", sender: self)
    }
    
    func startAnimations() {
        
        //Notification bell
        loadLottie(fileName: "bell", x: 340, y: 50, width: 30, height: 30, loopStatus: false, enableTouch: true)
        //Moving car
        loadLottie(fileName: "bluecar", x: 0, y: 300, width: self.view.frame.size.width, height: 100, loopStatus: false, enableTouch: true)
        //location arrow
        loadLottie(fileName: "arrow", x: Int(self.view.bounds.midX-85), y: Int(self.view.bounds.midY-57), width: 60, height: 60, loopStatus: true, enableTouch: false)
        
        //tempLabelMenu.transform = CGAffineTransform(rotationAngle: -3.14/2)
        //Lock and Unlock button
        
        
        
    }
    
    func loadLottie(fileName: String, x: Int, y: Int, width: CGFloat, height: CGFloat, loopStatus: Bool, enableTouch: Bool)
    {
        animationView = LAAnimationView.animationNamed(fileName)
        animationView?.frame = CGRect(x: x, y: y, width: Int(width), height: Int(height))
        animationView?.contentMode = .scaleAspectFill
        animationView?.isUserInteractionEnabled = enableTouch
        animationView?.loopAnimation = loopStatus
        self.view.addSubview(animationView!)
        animationView?.play()
        applyMotionEffect(toView: animationView!, magnitude: 50)
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func applyMotionEffect (toView view:LAAnimationView, magnitude:Float) {
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

}
