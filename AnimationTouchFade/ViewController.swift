//
//  ViewController.swift
//  AnimationTouchFade
//
//  Created by George Joseph Kristian on 17/05/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

var selectorMode: Int = 0

class ViewController: UIViewController {

    @IBOutlet weak var target: UIView!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        target.layer.cornerRadius = target.frame.size.width/2
        target.clipsToBounds = true
    }
    
    @IBAction func targetTapped(_ gestureRecognizer : UITapGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            // check selectorMode
            switch selectorMode{
            case 1:
                target.fadeTo(x: CGFloat(Int.random(in: 0 ... 414)), y: CGFloat(Int.random(in: 80 ... 896)))
            default:
                // move random to x, y
                target.moveTo(x: CGFloat(Int.random(in: 0 ... 414)), y: CGFloat(Int.random(in: 80 ... 896)), duration: 1)
            }
        }
    }
    
    @IBAction func selectorModeTapped(_ sender: Any) {
        selectorMode = modeSelector.selectedSegmentIndex
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
    
    func fadeTo(x: CGFloat, y: CGFloat){
        UIView.animate(withDuration: 0.5, animations: {
            self.fadeOut()
        }) { (finished) in
            if finished {
                self.moveTo(x: x, y: y, duration: 0)
                self.backgroundColor = self.generateRandomColor()
                UIView.animate(withDuration: 2, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
                    self.fadeIn()
                })
            }
        }
    }
    
    func fadeIn(){
        self.alpha = 1
        self.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
    
    func fadeOut(){
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 7, y: 7)
    }
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}

