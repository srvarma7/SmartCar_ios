//
//  ProfileViewController.swift
//  OnboardingLottie
//
//  Created by Sai Raghu Varma Kallepalli on 6/11/19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import UIKit
import MapKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progress: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var otherCardLabel: UILabel!
    @IBOutlet weak var userOneImg: UIImageView!
    @IBOutlet weak var userOneLabel: UILabel!
    @IBOutlet weak var userTwoImg: UIImageView!
    @IBOutlet weak var userTwoLabel: UILabel!
    @IBOutlet weak var userThreeImg: UIImageView!
    @IBOutlet weak var userThreeLabel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moveLabels(y: -170)
        // Do any additional setup after loading the view.
    }
    
    
    func moveLabels(y: CGFloat) {
        UIView.animate(withDuration: 2, animations: {
            self.profileView.transform = CGAffineTransform(translationX: 0, y: 460)
            self.profileLabel.transform = CGAffineTransform(translationX: 0, y: 460)
            self.mapView.transform = CGAffineTransform(translationX: 0, y: 210)
        })
        UIView.animate(withDuration: 1, animations: {
            self.score.transform = CGAffineTransform(translationX: 150, y: 0)
            self.scoreLabel.transform = CGAffineTransform(translationX: 150, y: 0)
            self.progress.transform = CGAffineTransform(translationX: -150, y: 0)
            self.progressLabel.transform = CGAffineTransform(translationX: -150, y: 0)
            self.bgImage.transform = CGAffineTransform(translationX: 0, y: y)
            self.otherCardLabel.transform = CGAffineTransform(translationX: 0, y: y)
            self.userOneImg.transform = CGAffineTransform(translationX: 0, y: y)
            self.userOneLabel.transform = CGAffineTransform(translationX: 0, y: y)
            self.userTwoImg.transform = CGAffineTransform(translationX: 0, y: y)
            self.userTwoLabel.transform = CGAffineTransform(translationX: 0, y: y)
            self.userThreeImg.transform = CGAffineTransform(translationX: 0, y: y)
            self.userThreeLabel.transform = CGAffineTransform(translationX: 0, y: y)
            self.bgImage.layer.cornerRadius = (self.bgImage.frame.size.width)/10
//            self.bgImage.layer.borderWidth = 5
//            self.bgImage.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.bgImage.clipsToBounds = true
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
