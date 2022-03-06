//
//  HomeViewController.swift
//  GIFKeyboard_Example
//
//  Created by Antoine Thiel on 05/03/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import GIFKeyboard

class HomeViewController: UIViewController {
    
    @IBOutlet weak var customView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.present(GIFKeyboard.getGIFModal(), animated: true, completion: nil)
        GIFKeyboard.start(view: customView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
