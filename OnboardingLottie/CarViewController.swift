//
//  CarViewController.swift
//  OnboardingLottie
//
//  Created by Sai Raghu Varma Kallepalli on 5/11/19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//
//Source for Car image - Car PNG Top View Png link - "http://pluspng.com/car-png-top-view-png-3190.html"



import UIKit
import Lottie

class CarViewController: UIViewController {

    @IBOutlet weak var speedTopBG: UIImageView!
    @IBOutlet weak var tempTopBg: UIImageView!
    
    @IBOutlet weak var speedTopLabel: UILabel!
    @IBOutlet weak var speedCurrent: UILabel!
    @IBOutlet weak var currentSpeedNumberLabel: UILabel!
    @IBOutlet weak var speedMax: UILabel!
    @IBOutlet weak var maxSpeedNumberLabel: UILabel!
    
    @IBOutlet weak var speedImgBg: UIImageView!
    @IBOutlet weak var tempImgBg: UIImageView!
    
    @IBOutlet weak var tempTopLabel: UILabel!
    @IBOutlet weak var tempOut: UILabel!
    @IBOutlet weak var tempOutNumLabel: UILabel!
    @IBOutlet weak var insideTemp: UILabel!
    @IBOutlet weak var insideTempNumLabel: UILabel!
    
    @IBOutlet weak var blackBg: UIImageView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var distanceNumberLabel: UILabel!
    
    var imageView = UIImageView()
    
    var animationView = LAAnimationView.animationNamed("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadLottie(fileName: "bright", x: 0, y: 500, width: self.view.frame.size.width, height: 300, loopStatus: true, enableTouch: false)
        
        //initializeAnimations()
        self.loadLottie(fileName: "radar", x: 126, y: 40, width: 170, height: 500, loopStatus: true, enableTouch: false, magnitude: 3, play: false)
        addCarImage()
        startAnimation()
        let seconds = 3.0
        let y: CGFloat = -170
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            UIView.animate(withDuration: 1, animations: {
                self.blackBg.transform = CGAffineTransform(translationX: 0, y: y)
                self.distance.transform = CGAffineTransform(translationX: 0, y: y)
                self.distanceNumberLabel.transform = CGAffineTransform(translationX: 0, y: y)
                
                
            })
        }
//        addBlurEffect(iv: speedTopBG, x: 0, y: 185)
//        addBlurEffect(iv: tempTopBg, x: 300, y: 185)
//        addBlurEffect(iv: speedImgBg)
//        addBlurEffect(iv: speedTopBG)
    }
    
    func startAnimation() {
        let x: CGFloat = 90
        let y: CGFloat = -90
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            UIView.animate(withDuration: 1, animations: {
                self.imageView.transform = CGAffineTransform(translationX: 0, y: -780)
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds+1) {
            UIView.animate(withDuration: 1, animations: {
                self.animationView?.play()
                self.animationView?.isHidden = false
                self.speedTopBG.transform = CGAffineTransform(translationX: x, y: 0)
                self.speedImgBg.transform = CGAffineTransform(translationX: x, y: 0)
                self.speedTopLabel.transform = CGAffineTransform(translationX: x, y: 0)
                self.speedCurrent.transform = CGAffineTransform(translationX: x, y: 0)
                self.currentSpeedNumberLabel.transform = CGAffineTransform(translationX: x, y: 0)
                self.speedMax.transform = CGAffineTransform(translationX: x, y: 0)
                self.maxSpeedNumberLabel.transform = CGAffineTransform(translationX: x, y: 0)
                self.tempTopBg.transform = CGAffineTransform(translationX: y, y: 0)
                self.tempImgBg.transform = CGAffineTransform(translationX: y, y: 0)
                self.tempTopLabel.transform = CGAffineTransform(translationX: y-2, y: 0)
                self.tempOut.transform = CGAffineTransform(translationX: y, y: 0)
                self.tempOutNumLabel.transform = CGAffineTransform(translationX: y, y: 0)
                self.insideTemp.transform = CGAffineTransform(translationX: y, y: 0)
                self.insideTempNumLabel.transform = CGAffineTransform(translationX: y, y: 0)
                
                self.tempImgBg.layer.cornerRadius = (self.blackBg.frame.size.width)/10
                self.tempImgBg.clipsToBounds = true
                
                self.speedImgBg.layer.cornerRadius = (self.blackBg.frame.size.width)/10
                self.speedImgBg.clipsToBounds = true
                
//                self.speedTopBG.layer.cornerRadius = (self.blackBg.frame.size.width)/10
//                self.speedTopBG.clipsToBounds = true
//
//                self.tempTopBg.layer.cornerRadius = (self.blackBg.frame.size.width)/10
//                self.tempTopBg.clipsToBounds = true
                
                self.blackBg.layer.cornerRadius = (self.blackBg.frame.size.width)/10
                self.blackBg.clipsToBounds = true
            })
        }
    }
    
    func initializeAnimations() {
//        loadLottie(fileName: "dark", x: 50, y: 700, width: 100, height: 100, loopStatus: true, enableTouch: false, magnitude: -5)
//        loadLottie(fileName: "caution", x: 160, y: 70, width: 100, height: 100, loopStatus: true, enableTouch: false, magnitude: 0)
//        loadLottie(fileName: "stop", x: 160, y: 70, width: 100, height: 100, loopStatus: true, enableTouch: false, magnitude: 0)
    }

    func addCarImage() {
        imageView  = UIImageView(frame:CGRect(x: 95, y: 1020, width: 230, height: 400));
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named:"redcar")
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
    
    func loadLottie(fileName: String, x: Int, y: Int, width: CGFloat, height: CGFloat, loopStatus: Bool, enableTouch: Bool, magnitude: Float, play: Bool)
        {
            animationView = LAAnimationView.animationNamed(fileName)
            animationView?.frame = CGRect(x: x, y: y, width: Int(width), height: Int(height))
            animationView?.contentMode = .scaleAspectFill
            animationView?.isUserInteractionEnabled = enableTouch
            animationView?.loopAnimation = loopStatus
            animationView?.loopAnimation = loopStatus
            self.view.addSubview(animationView!)
            if play {
                animationView?.play()
                
            }
            animationView?.isHidden = true
            applyMotionEffect(toView: animationView!, magnitude: magnitude)
            
            
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
