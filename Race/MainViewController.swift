//
//  ViewController.swift
//  Race
//
//  Created by Damon Cricket on 28.01.2020.
//  Copyright © 2020 DC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    struct Constants {
        struct Space {
            static let width: CGFloat = 20.0
            static let height: CGFloat = 30.0
        }
        struct Car {
            static let width: CGFloat = 50.0
            static let height: CGFloat = 100.0
        }
    }
    
    var firstSpace = UIView()
    var secondSpace = UIView()
    var thirdSpace = UIView()
    var fourthSpace = UIView()
    
    var car = UIView()
    
    var obstacle = UIView()
    
    var firstSpaceEmiter = Emiter()
    var secondSpaceEmiter = Emiter()
    var thirdSpaceEmiter = Emiter()
    var fourthSpaceEmiter = Emiter()
    
    var obstacleEmiter = Emiter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stripWidth: CGFloat = Constants.Space.width
        let bounds = view.bounds
        let firstStripView = UIView(frame: CGRect(x: bounds.width/3 - stripWidth/2, y: 0.0, width: stripWidth, height: bounds.height))
        firstStripView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(firstStripView)
        
        let secondStripView = UIView(frame: CGRect(x: 2*bounds.width/3 - stripWidth/2, y: 0.0, width: stripWidth, height: bounds.height))
        secondStripView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(secondStripView)
        
        
    }
}

