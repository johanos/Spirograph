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
    
    var pointCollection : [CGPoint] = []
    var paths           : [CAShapeLayer] = []
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var smallGear: CircleView!
    @IBOutlet weak var smallGearContainer: UIView!
    @IBOutlet weak var bigGear: CircleView!
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
            let point = touch.locationInView(self.view)
            if detectAndValidateScreenTouch(point){
                pointCollection.append(point)
            }
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
    
    func detectAndValidateScreenTouch(pointInScreen : CGPoint) -> Bool
    {
        let touchCGRect = CGRectMake(smallGear.frame.minX + smallGearContainer.frame.minX, smallGear.frame.minY + smallGearContainer.frame.minY, smallGear.frame.width, smallGear.frame.height)
        
        return CGRectContainsPoint(touchCGRect, pointInScreen)
    }

    @IBAction func startButtonWasPressed(sender: AnyObject) {
        runSpinAnimationOnView(smallGearContainer, duration: 10.0, rotations: 1, repetitions: 1)
        
        for point in pointCollection{
            let bezierPath     = spirographBezierPathForPoint(point)
            let bezier         = CAShapeLayer()
            bezier.path        = bezierPath.CGPath
            bezier.strokeColor = UIColor.purpleColor().CGColor
            bezier.fillColor   = UIColor.clearColor().CGColor
            bezier.lineWidth   = CGFloat(3.0)
            bezier.strokeStart = CGFloat(0.0)
            bezier.strokeEnd   = CGFloat(0.5)
            self.view.layer.addSublayer(bezier)
            paths.append(bezier)
            
            let animateStrokeEnd = CABasicAnimation(keyPath:"strokeEnd")
            animateStrokeEnd.duration = 30.0;
            animateStrokeEnd.fromValue = NSNumber(float: 0.0)
            animateStrokeEnd.toValue   = NSNumber(float: 0.5)
            bezier.addAnimation(animateStrokeEnd, forKey: "strokeEndAnimation")
            
        }
    }
    

    func spirographBezierPathForPoint(point : CGPoint) -> UIBezierPath{
        let path   = UIBezierPath()
        var startPoint : CGPoint
        
        for t in  0.0.stride(to: 700, by: 0.25) {
            
            let R      = bigGear.circleRadius
            let r      = smallGear.circleRadius
            let a      = Double(sqrt( pow(smallGear.center.x - point.x, 2) + pow(smallGear.center.y - point.y, 2)))
            let deltaR = R - R
            let ratioR = r / R
            
            
            // x(t) = (R-r)*cos((r/R) *t) + a*cos((1-(r/R))*t)
            // y(t) = (R-r)*sin((r/R) *t) - a*sin((1-(r/R))*t)
            
            let x      = (deltaR) * cos( (ratioR) * t) + a * cos((1 - (ratioR)) * t)
            let y      = (deltaR) * sin( (ratioR) * t) - a * sin((1 - (ratioR)) * t)
            startPoint = CGPoint(x: Double(bigGear.center.x) + x , y: Double(bigGear.center.y) + y)
            path.addLineToPoint(startPoint)
            path.moveToPoint(startPoint)
            
        }
        
        return path
    }
    
    @IBAction func clearButtonWasPressed(sender: UIButton) {
        if let layers = self.view.layer.sublayers {
            
            for path in paths {
                path.removeFromSuperlayer()
            }
            
            pointCollection.removeAll()
            
        }
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

