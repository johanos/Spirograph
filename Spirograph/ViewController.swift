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
    @IBOutlet weak var smallGearContainer: UIView!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        slider.maximumValue = Float(smallGearContainer.bounds.size.width / 2)
        
     }
    override func viewDidAppear(animated: Bool) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sliderValueChanged(sender: UISlider) {
        self.sliderLabel.text = "Value: " + String(sender.value)
        
        var oldCenter = smallGear.center
        smallGear.frame = CGRectMake(smallGear.frame.minX, smallGear.frame.minY, CGFloat(sender.value), CGFloat(sender.value))
    
        let delta = oldCenter.x - smallGear.center.x;
        oldCenter = CGPoint( x: oldCenter.x + delta, y: oldCenter.y);
        smallGear.center = oldCenter;
        smallGear.setNeedsUpdateConstraints();
        smallGear.setNeedsDisplay();
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let touchCGRect = CGRectMake(smallGear.frame.minX + smallGearContainer.frame.minX, smallGear.frame.minY + smallGearContainer.frame.minY, smallGear.frame.width, smallGear.frame.height)

            print ( CGRectContainsPoint(touchCGRect, touch.locationInView(self.view)))
        }
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

    @IBAction func startButtonWasPressed(sender: AnyObject) {
        runSpinAnimationOnView(smallGearContainer, duration: 10.0, rotations: 1, repetitions: 1)
    }

    func changeAnchorPointOfView(view : UIView , superView : UIView? , rotationPoint : CGPoint)
    {
        let oldFrame = view.frame
        let minX   = CGRectGetMinX(view.frame)
        let minY   = CGRectGetMinY(view.frame)
        let width  = CGRectGetWidth(view.frame)
        let heigth = CGRectGetHeight(view.frame)
        let anchorPointX = ((rotationPoint.x - minX) / width)
        let anchorPointY = ((rotationPoint.y - minY) / heigth)

        let anchorPoint = CGPointMake( anchorPointX , anchorPointY )

        view.layer.anchorPoint = anchorPoint
        view.layer.frame = oldFrame
    }

    func removeAllConstraintsFromView(view :UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.removeConstraints(view.constraints)
    }


}

