//
//  CircleView.swift
//  Spirograph
//
//  Created by Johan Ospina on 6/25/16.
//  Copyright © 2016 Johan Ospina. All rights reserved.
//

import UIKit

class CircleView: UIView {
    var circleLayer : CAShapeLayer!
    var backgroundColorPreset: UIColor? = nil //UIColor.clearColor()
    var circleRadius : Double {
        get
        {
            return Double(self.bounds.height - 10)
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.setupCALayer(backgroundColorPreset)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setupCALayer(backgroundColorPreset)
    }

    override func prepareForInterfaceBuilder() {
        self.setupCALayer(backgroundColorPreset)
    }
    
    
    override func drawRect(rect: CGRect) {
    // Get the Graphics Context
    let context = UIGraphicsGetCurrentContext();
    
    // Set the circle outerline-width
    CGContextSetLineWidth(context, 5.0);
    
    // Set the circle outerline-colour
    UIColor.redColor().set()
    
    // Create Circle
    CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (frame.size.width - 5)/2, 0.0, CGFloat(M_PI * 2.0), 1)
    
    // Draw
    CGContextStrokePath(context);
    }
    
    func setupCALayer(color : UIColor? ) -> Void {
        if let backgroundPaint = color {
            self.backgroundColor = backgroundPaint
        }

        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 5)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor.redColor().CGColor
        circleLayer.lineWidth = 5.0;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
    }
}
