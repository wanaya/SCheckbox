//
//  ViewController.swift
//  SCheckbox
//
//  Created by Guillermo Anaya Magallón on 25/09/14.
//  Copyright (c) 2014 wanaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var check: SCheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.check.color(UIColor.grayColor(), forState: UIControlState.Normal)
        self.check.textLabel.text = "this is a checkbox"
        self.check.addTarget(self, action: "tapCheck:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func tapCheck(checkBox: SCheckBox!){
        print("\(checkBox.checked)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

