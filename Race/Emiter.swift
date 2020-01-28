//
//  Emiter.swift
//  Race
//
//  Created by Damon Cricket on 28.01.2020.
//  Copyright © 2020 DC. All rights reserved.
//

import Foundation
import UIKit

protocol EmiterDelegate: class {
    func emiter(_ emiter: Emiter, didMoveView view: UIView)
}

class Emiter {
    weak var delegate: EmiterDelegate?
    weak var view: UIView?
    var yOffset: CGFloat = 0.0
    var timeInterval: TimeInterval = 0.0
    var timer: Timer?
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerTick(timer:)), userInfo: nil, repeats: true)
    }
    
    @objc func timerTick(timer: Timer) {
        view?.frame = CGRect(x: view!.frame.minX, y: view!.frame.minY + yOffset, width: view!.frame.width, height: view!.frame.height)
        delegate?.emiter(self, didMoveView: view!)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
