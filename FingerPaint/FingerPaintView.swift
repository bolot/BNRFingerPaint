//
//  FingerPaintView.swift
//  FingerPaint
//
//  Created by Bolot Kerimbaev on 1/30/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

class FingerPaintView: UIView {
    var paths = [UIBezierPath]()
    var pathsInProgress = [UITouch:UIBezierPath]()

    override func drawRect(rect: CGRect) {
        // Drawing code
        UIColor.blackColor().setStroke()
        for path in paths {
            path.stroke()
        }
        UIColor.redColor().setStroke()
        for (touch, path) in pathsInProgress {
            path.stroke()
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches.allObjects as [UITouch] {
            let path = UIBezierPath()
            path.moveToPoint(touch.locationInView(self))
            pathsInProgress[touch] = path
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches.allObjects as [UITouch] {
            let path = pathsInProgress[touch]
            path?.addLineToPoint(touch.locationInView(self))
        }
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches.allObjects as [UITouch] {
            if let path = pathsInProgress.removeValueForKey(touch) {
                paths.append(path)
            }
        }
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        for touch in touches.allObjects as [UITouch] {
            pathsInProgress.removeValueForKey(touch)
        }
        self.setNeedsDisplay()
    }

    func resetView() {
        paths = [UIBezierPath]()
        pathsInProgress = [UITouch:UIBezierPath]()
    }
}
