//
//  ViewController.swift
//  Spirograph
//
//  Created by Johan Ospina on 6/25/16.
//  Copyright © 2016 Johan Ospina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var smallGear: CircleView!
    @IBOutlet weak var bigGear: CircleView!
    @IBOutlet weak var sliderLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sliderValueChanged(sender: UISlider) {
        self.sliderLabel.text = "Value: " + String(sender.value)
    }


}

