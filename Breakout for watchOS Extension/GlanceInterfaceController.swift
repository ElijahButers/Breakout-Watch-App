//
//  GlanceInterfaceController.swift
//  Breakout
//
//  Created by User on 5/19/16.
//  Copyright © 2016 temporary. All rights reserved.
//

import WatchKit
import Foundation


class GlanceInterfaceController: WKInterfaceController {
  
  @IBOutlet var titleLabel: WKInterfaceLabel!
  @IBOutlet var lowerSectionGroup: WKInterfaceGroup!
  @IBOutlet var workoutImage: WKInterfaceImage!
  @IBOutlet var workoutNameLabel: WKInterfaceLabel!
  @IBOutlet var timerLabel: WKInterfaceTimer!
  
  let workoutManager  = WorkoutManager.defaultManager
  
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
  
  func showNextUpUI() {
    workoutImage.setHidden(false)
    workoutImage.setImageNamed(workoutManager.nextWorkout.imageName)
    workoutNameLabel.setHidden(false)
    workoutNameLabel.setText(workoutManager.nextWorkout.name)
    titleLabel.setText("Next breakout...")
    titleLabel.setTextColor(UIColor.darkGrayColor())
    lowerSectionGroup.setBackgroundImage(nil)
    timerLabel.setHidden(true)
  }
  
  func showActiveUI(remaining: NSTimeInterval) {
    
    let location = Int(workoutManager.percentComplete * Double(circularProgressAnimationFrames))
    lowerSectionGroup.setBackgroundImageNamed("progress")
    lowerSectionGroup.startAnimatingWithImagesInRange(NSRange(location: location, length: circularProgressAnimationFrames), duration: remaining, repeatCount: 1)
    workoutImage.setHidden(true)
    workoutNameLabel.setHidden(true)
    titleLabel.setTextColor(UIColor.whiteColor())
    titleLabel.setText(workoutManager.currentWorkout.name)
    
    timerLabel.setHidden(false)
    timerLabel.setDate(NSDate(timeIntervalSinceNow: remaining))
    timerLabel.start()
    NSTimer.scheduledTimerWithTimeInterval(remaining, target: self, selector: "showTrophy", userInfo: nil, repeats: false)
  }

}
