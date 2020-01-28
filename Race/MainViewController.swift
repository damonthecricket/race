//
//  ViewController.swift
//  Race
//
//  Created by Damon Cricket on 28.01.2020.
//  Copyright © 2020 DC. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, EmiterDelegate {
    struct Constants {
        struct Space {
            static let width: CGFloat = 20.0
            static let height: CGFloat = 30.0
        }
        struct Car {
            static let width: CGFloat = 50.0
            static let height: CGFloat = 100.0
        }
        struct Obstacle {
            static let size: CGFloat = 100.0
        }
    }
    
    var blindView: UIView = UIView()
    var startButton: UIButton = UIButton()
    
    var firstSpaceView = UIView()
    var secondSpaceView = UIView()
    var thirdSpaceView = UIView()
    var fourthSpaceView = UIView()
    
    var carView = UIView()
    
    var obstacleView = UIView()
    
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
        
        firstSpaceView.frame = CGRect(x: firstStripView.frame.minX, y: bounds.height/3 - Constants.Space.height/2, width: Constants.Space.width, height: Constants.Space.height)
        firstSpaceView.backgroundColor = .white
        view.addSubview(firstSpaceView)
        
        secondSpaceView.frame = CGRect(x: firstStripView.frame.minX, y: 2*bounds.height/3 - Constants.Space.height/2, width: Constants.Space.width, height: Constants.Space.height)
        secondSpaceView.backgroundColor = .white
        view.addSubview(secondSpaceView)
        
        thirdSpaceView.frame = CGRect(x: secondStripView.frame.minX, y: firstSpaceView.frame.minY - Constants.Space.height, width: Constants.Space.width, height: Constants.Space.height)
        thirdSpaceView.backgroundColor = .white
        view.addSubview(thirdSpaceView)
        
        fourthSpaceView.frame = CGRect(x: secondStripView.frame.minX, y: secondSpaceView.frame.minY - Constants.Space.height, width: Constants.Space.width, height: Constants.Space.height)
        fourthSpaceView.backgroundColor = .white
        view.addSubview(fourthSpaceView)

        carView.frame = CGRect(x: bounds.width/2 - Constants.Car.width/2, y: bounds.height - Constants.Car.height, width: Constants.Car.width, height: Constants.Car.height)
        carView.backgroundColor = .black
        view.addSubview(carView)
        
        placeObstacle()
        obstacleView.backgroundColor = .red
        view.addSubview(obstacleView)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer(recognizer:)))
        view.addGestureRecognizer(gesture)
        
        blindView.frame = bounds
        blindView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.addSubview(blindView)
        
        let startButtonWidth: CGFloat = 150.0
        let startButtonHeight: CGFloat = 50.0
        startButton.frame = CGRect(x: bounds.width/2 - startButtonWidth/2, y: bounds.height/2 - startButtonHeight/2, width: startButtonWidth, height: startButtonHeight)
        startButton.addTarget(self, action: #selector(startButtonTap(sender:)), for: .touchUpInside)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
        startButton.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0), for: .normal)
        startButton.layer.borderColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0).cgColor
        startButton.layer.borderWidth = 3.0
        startButton.layer.cornerRadius = 3.0
        startButton.setTitle("Start", for: .normal)
        blindView.addSubview(startButton)
        
        firstSpaceEmiter.delegate = self
        firstSpaceEmiter.yOffset = 1.0
        firstSpaceEmiter.timeInterval = 0.001
        firstSpaceEmiter.view = firstSpaceView
        
        secondSpaceEmiter.delegate = self
        secondSpaceEmiter.yOffset = 1.0
        secondSpaceEmiter.timeInterval = 0.001
        secondSpaceEmiter.view = secondSpaceView
        
        thirdSpaceEmiter.delegate = self
        thirdSpaceEmiter.yOffset = 1.0
        thirdSpaceEmiter.timeInterval = 0.001
        thirdSpaceEmiter.view = thirdSpaceView
        
        fourthSpaceEmiter.delegate = self
        fourthSpaceEmiter.yOffset = 1.0
        fourthSpaceEmiter.timeInterval = 0.001
        fourthSpaceEmiter.view = fourthSpaceView
        
        obstacleEmiter.delegate = self
        obstacleEmiter.yOffset = 1.0
        obstacleEmiter.timeInterval = 0.001
        obstacleEmiter.view = obstacleView
    }
    
    @objc func panGestureRecognizer(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        carView.center = CGPoint(x: carView.center.x + translation.x, y: carView.center.y)
        if carView.frame.minX < 0.0 {
            carView.frame = CGRect(x: 0.0, y: carView.frame.minY, width: carView.frame.width, height: carView.frame.height)
        } else if carView.frame.maxX > view.bounds.width {
            carView.frame = CGRect(x: view.bounds.width - Constants.Car.width, y: carView.frame.minY, width: carView.frame.width, height: carView.frame.height)
        }
        recognizer.setTranslation(.zero, in: view)
    }
    
    @objc func startButtonTap(sender: UIButton) {
        blindView.isHidden = true
        
        firstSpaceEmiter.start()
        secondSpaceEmiter.start()
        thirdSpaceEmiter.start()
        fourthSpaceEmiter.start()
        obstacleEmiter.start()
    }
    
    func emiter(_ emiter: Emiter, didMoveView v: UIView) {
        if firstSpaceView.frame.minY >= view.bounds.height {
            firstSpaceView.frame = CGRect(x: firstSpaceView.frame.minX, y: -firstSpaceView.bounds.height, width: firstSpaceView.bounds.width, height: firstSpaceView.bounds.height)
        }
        if secondSpaceView.frame.minY >= view.bounds.height {
            secondSpaceView.frame = CGRect(x: secondSpaceView.frame.minX, y: -secondSpaceView.bounds.height, width: secondSpaceView.bounds.width, height: secondSpaceView.bounds.height)
        }
        if thirdSpaceView.frame.minY >= view.bounds.height {
            thirdSpaceView.frame = CGRect(x: thirdSpaceView.frame.minX, y: -thirdSpaceView.bounds.height, width: thirdSpaceView.bounds.width, height: thirdSpaceView.bounds.height)
        }
        if fourthSpaceView.frame.minY >= view.bounds.height {
            fourthSpaceView.frame = CGRect(x: fourthSpaceView.frame.minX, y: -fourthSpaceView.bounds.height, width: fourthSpaceView.bounds.width, height: fourthSpaceView.bounds.height)
        }
        if obstacleView.frame.minY >= view.bounds.height {
            let index = Int.random(in: 0 ... 2)
            let obstacleSize = Constants.Obstacle.size
            let obstacleY = -obstacleSize
            if index == 0 {
                obstacleView.frame = CGRect(x: view.bounds.width/6 - obstacleSize/2, y: obstacleY, width: obstacleSize, height: obstacleSize)
            } else if index == 1 {
                obstacleView.frame = CGRect(x: view.bounds.width/2 - obstacleSize/2, y: obstacleY, width: obstacleSize, height: obstacleSize)
            } else if index == 2 {
                obstacleView.frame = CGRect(x: 5*view.bounds.width/6 - obstacleSize/2, y: obstacleY, width: obstacleSize, height: obstacleSize)
            }
        }
        if carView.frame.intersects(obstacleView.frame) {
            firstSpaceEmiter.stop()
            secondSpaceEmiter.stop()
            thirdSpaceEmiter.stop()
            fourthSpaceEmiter.stop()
            obstacleEmiter.stop()
            blindView.isHidden = false
            placeObstacle()
        }
    }
    
    func placeObstacle() {
        obstacleView.frame = CGRect(x: view.bounds.width/2 - Constants.Obstacle.size/2, y: -Constants.Obstacle.size, width: Constants.Obstacle.size, height: Constants.Obstacle.size)
    }
}

