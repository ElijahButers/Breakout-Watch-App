//
//  TrophyInterfaceController.swift
//  Breakout
//
//  Created by temporary on 9/1/15.
//  Copyright © 2015 temporary. All rights reserved.
//

import WatchKit
import Foundation


class TrophyInterfaceController: WKInterfaceController {
  
  let workoutManager = WorkoutManager.defaultManager
  
  var willAnimate = false
  
  @IBOutlet var lastWorkoutGroup: WKInterfaceGroup!
  @IBOutlet var lastWorkoutTimeLabel: WKInterfaceLabel!
  @IBOutlet var lastWorkoutNameLabel: WKInterfaceLabel!
  @IBOutlet var totalLabel: WKInterfaceLabel!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    if let context = context as? String {
      if context == "animate" {
        willAnimate = true
        becomeCurrentPage()
      }
    }
    
    totalLabel.setText("\(0)")
  }
  
  override func willActivate() {
    super.willActivate()
    
    updateUI()
  }
  
  override func didAppear() {
    super.didAppear()
    
    if willAnimate {
      totalLabel.setText(String(workoutManager.completedWorkouts.count))
    }
    willAnimate = false
  }

  @IBAction func undoButtonPressed() {
    workoutManager.removeLastWorkout()
    updateUI()
  }
  
  func updateUI() {
    var total = workoutManager.completedWorkouts.count
    if willAnimate {
      total--
    }
    totalLabel.setText(String(total))
    
    if let lastWorkout = workoutManager.completedWorkouts.last {
      lastWorkoutGroup.setHidden(false)
      lastWorkoutNameLabel.setText(lastWorkout.workout.name)
      lastWorkoutTimeLabel.setText(lastWorkout.friendlyTime)
    } else {
      lastWorkoutGroup.setHidden(true)
    }

  }
}
