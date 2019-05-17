//
//  ViewController.swift
//  AnimationTouchFade
//
//  Created by George Joseph Kristian on 17/05/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var target: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        target.layer.cornerRadius = target.frame.size.width/2
        target.clipsToBounds = true
    }
    
    @IBAction func targetTapped(_ gestureRecognizer : UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            // move random to x, y
            target.moveTo(x: CGFloat(Int.random(in: 0 ... 414)), y: CGFloat(Int.random(in: 0 ... 896)), duration: 1)
        }
    }
}

extension UIView {
    func moveTo(x: CGFloat, y: CGFloat, duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.center.x = x
            self.center.y = y
            self.backgroundColor = self.generateRandomColor()
        })
    }
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}

