//
//  CarViewController.swift
//  OnboardingLottie
//
//  Created by Sai Raghu Varma Kallepalli on 5/11/19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import UIKit
import Lottie

class CarViewController: UIViewController {

    @IBOutlet weak var speedTopBG: UIImageView!
    @IBOutlet weak var tempTopBg: UIImageView!
    @IBOutlet weak var speedImgBg: UIImageView!
    @IBOutlet weak var tempImgBg: UIImageView!
    
    var animationView = LAAnimationView.animationNamed("")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLottie(fileName: "radar", x: 124, y: 40, width: 170, height: 500, loopStatus: true, enableTouch: false)
        loadLottie(fileName: "dark", x: 50, y: 700, width: 100, height: 100, loopStatus: true, enableTouch: false)
        loadLottie(fileName: "caution", x: 160, y: 70, width: 100, height: 100, loopStatus: true, enableTouch: false)
        loadLottie(fileName: "stop", x: 160, y: 70, width: 100, height: 100, loopStatus: true, enableTouch: false)
        //loadLottie(fileName: "bright", x: 0, y: 500, width: self.view.frame.size.width, height: 300, loopStatus: true, enableTouch: false)
        addCarImage()
//        addBlurEffect(iv: speedTopBG, x: 0, y: 185)
//        addBlurEffect(iv: tempTopBg, x: 300, y: 185)
//        addBlurEffect(iv: speedImgBg)
//        addBlurEffect(iv: speedTopBG)
    }

    func addCarImage()
    {
        var imageView : UIImageView
        imageView  = UIImageView(frame:CGRect(x: 110, y: 230, width: 200, height: 400));
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named:"cartopview")
        self.view.addSubview(imageView)
    }
    
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
    
    func addBlurEffect(iv: UIImageView, x: CGFloat, y: CGFloat)
    {
        if #available(iOS 13.0, *) {
            let blurEffect = UIBlurEffect(style: .regular)
            let blurredEffectView = UIVisualEffectView(effect: blurEffect)
            blurredEffectView.frame = iv.bounds
            blurredEffectView.transform = CGAffineTransform(translationX: x, y: y)
            view.addSubview(blurredEffectView)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func loadLottie(fileName: String, x: Int, y: Int, width: CGFloat, height: CGFloat, loopStatus: Bool, enableTouch: Bool)
        {
            animationView = LAAnimationView.animationNamed(fileName)
            animationView?.frame = CGRect(x: x, y: y, width: Int(width), height: Int(height))
            animationView?.contentMode = .scaleAspectFill
            animationView?.isUserInteractionEnabled = enableTouch
            animationView?.loopAnimation = loopStatus
            animationView?.loopAnimation = loopStatus
            self.view.addSubview(animationView!)
            animationView?.play()
            applyMotionEffect(toView: animationView!, magnitude: 50)
            
            
    //        animationView?.play(fromFrame: 0, toFrame: 66)
    //        animationView.play(fromProgress: 0.5, toProgress: 1)
            
            //animationView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: T##CGFloat)
            //animationView?.frame = CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 300)
            
        
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func carTopButton(_ sender: Any) {
         _ = navigationController?.popToRootViewController(animated: true)
    }
    
}
