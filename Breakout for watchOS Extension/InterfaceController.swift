//
//  InterfaceController.swift
//  Breakout
//
//  Created by temporary on 9/1/15.
//  Copyright © 2015 temporary. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  
  let workoutManager = WorkoutManager.defaultManager
  var activeWorkout = false
  
  var timer = NSTimer()
  
  @IBOutlet var startButtonBackgroundGroup: WKInterfaceGroup!
  @IBOutlet var startButtonForegroundGroup: WKInterfaceGroup!
  @IBOutlet var timerLabel: WKInterfaceTimer!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    if let _ = workoutManager.timeRemaining {
      activeWorkout = true
      prepareForWorkout()
    } else {
      showNextUpUI()
    }
    
  }
  
  override func didDeactivate() {
    super.didDeactivate()
    activeWorkout = false
  }
  
  @IBAction func startButtonPressed() {
    if activeWorkout {
      showNextUpUI()
    } else {
      prepareForWorkout()
    }
    
  }
  
  func prepareForWorkout() {
    startButtonForegroundGroup.setBackgroundImage(nil)
    if !activeWorkout { // show countdown
      self.setTitle(workoutManager.nextWorkout.name)
      startButtonBackgroundGroup.setBackgroundImageNamed("progress")
      startButtonBackgroundGroup.startAnimatingWithImagesInRange(NSRange(location: 0, length: circularProgressAnimationFrames), duration: -3, repeatCount: 1)
      timerLabel.setHidden(false)
      timerLabel.setDate(NSDate(timeIntervalSinceNow: 4))
      timerLabel.start()
      delay(3) {
        guard self.activeWorkout else {
          return
        }
        self.workoutManager.start()
        self.showWorkoutTimer()
      }
    } else { // immediately show workout timer
      self.setTitle(workoutManager.completedWorkouts.last?.workout.name)
      showWorkoutTimer()
    }
    activeWorkout = true
  }
  
  func showWorkoutTimer() {
    guard activeWorkout else {
      return
    }
    let location = Int(workoutManager.percentComplete * Double(circularProgressAnimationFrames))
    startButtonBackgroundGroup.setBackgroundImageNamed("progress")
    startButtonBackgroundGroup.startAnimatingWithImagesInRange(NSRange(location: location, length: circularProgressAnimationFrames), duration: NSTimeInterval(workoutManager.timeRemaining!), repeatCount: 1)
    timerLabel.setDate(NSDate(timeIntervalSinceNow: NSTimeInterval(workoutManager.timeRemaining! + 1)))
    timerLabel.start()
    timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(workoutManager.timeRemaining!), target: self, selector: "showCompleted", userInfo: nil, repeats: false)
  }
  
  func showNextUpUI() {
    startButtonForegroundGroup.setBackgroundImageNamed(workoutManager.nextWorkout.imageName)
    timerLabel.setHidden(true)
    startButtonBackgroundGroup.stopAnimating()
    startButtonBackgroundGroup.setBackgroundImageNamed("progress")
    timer.invalidate()
    self.setTitle("Breakout")
  }
  
  func showCompleted() {
    guard activeWorkout else {
      return
    }
    activeWorkout = false
    WKInterfaceController.reloadRootControllers([("InitialController",""),("TrophyController","animate")])
  }
  
  override func handleUserActivity(userInfo: [NSObject : AnyObject]?) {
    
    guard let userInfo = userInfo,
      let action = userInfo["action"] as? String else { return }
    switch action {
    case  "startWorkout":
      prepareForWorkout()
    case "showTrophy":
      WKInterfaceController.reloadRootControllers([("InitialController", ""), ("TrophyController", "animate")])
    default:
      break
    }
  }

}
