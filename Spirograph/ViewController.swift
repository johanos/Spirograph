//
//  ViewController.swift
//  Spirograph
//
//  Created by Johan Ospina on 6/25/16.
//  Copyright © 2016 Johan Ospina. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
   
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var smallGear: CircleView!
    @IBOutlet weak var bigGear: CircleView!
    @IBOutlet weak var sliderLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //need to calculate the rotation point for the smaller view 

        let rotationPoint = CGPointMake( bigGear.frame.midX - 100.0 , bigGear.frame.midY - 100.0)


        changeAnchorPointOfView(smallGear, rotationPoint: rotationPoint)
//        runSpinAnimationOnView(smallGear, duration: 10.0, rotations: 1, repetitions: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sliderValueChanged(sender: UISlider) {
        self.sliderLabel.text = "Value: " + String(sender.value)
    }


    func runSpinAnimationOnView(view: UIView, duration : CFTimeInterval, rotations: Double, repetitions : Float)
    {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = NSNumber(double: M_PI * 2.0 * rotations)
        rotationAnimation.duration = duration
        rotationAnimation.cumulative = true
        rotationAnimation.repeatCount = repetitions
        view.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
    }

    func changeAnchorPointOfView(view : UIView , rotationPoint : CGPoint)
    {
//        let minX   = CGRectGetMinX(view.frame)
//        let minY   = CGRectGetMinY(view.frame)
//        let width  = CGRectGetWidth(view.frame)
//        let heigth = CGRectGetHeight(view.frame)
//        let anchorPointX = ((rotationPoint.x - minX) / width)
//        let anchorPointY = ((rotationPoint.y - minY) / heigth)
//
//        let anchorPoint = CGPointMake( anchorPointX , anchorPointY )
//        view.layer.anchorPoint = anchorPoint

        


}

