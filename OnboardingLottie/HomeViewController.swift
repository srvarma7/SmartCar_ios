//
//  HomeViewController.swift
//  OnboardingLottie
//
//  Created by Sai Raghu Varma Kallepalli on 4/11/19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {

    var animationView = LAAnimationView.animationNamed("tutorial")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLottie(fileName: "bluecar", x: 0, y: 50, width: self.view.frame.size.width, height: 300, loopStatus: true)
        
    }
    
    func loadLottie(fileName: String, x: Int, y: Int, width: CGFloat, height: CGFloat, loopStatus: Bool)
    {
        animationView = LAAnimationView.animationNamed(fileName)
        //animationView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: <#T##CGFloat#>)
        //animationView?.frame = CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 300)
        animationView?.frame = CGRect(x: x, y: y, width: Int(width), height: Int(height))
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopAnimation = loopStatus
        self.view.addSubview(animationView!)
        animationView?.play()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
