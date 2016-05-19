/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/


import Foundation

class WorkoutManager {
  
  static let defaultManager = WorkoutManager()
  
  var newlyCompletedWorkoutHasNotBeenShown = false
    
  var nextWorkout = workouts[0]
  
  var completedWorkouts = [CompletedWorkout]()
  
  let defaults = NSUserDefaults.standardUserDefaults()
  
  var timeRemaining: NSTimeInterval? {
    if let startTime = defaults.objectForKey("startTime") as? NSDate {
      if let duration = defaults.objectForKey("duration") as? NSTimeInterval {
        let expires = startTime.dateByAddingTimeInterval(duration)
        let remaining = -NSDate().timeIntervalSinceDate(expires)
        if remaining > 0 {
          return remaining
        }
      }
    }
    return nil
  }
  
  var percentComplete: Double { // between 0 and 1
    let duration = defaults.objectForKey("duration") as! NSTimeInterval
    if let remaining = timeRemaining {
      return 1 - ( remaining / duration )
    } else {
      return 1
    }
  }
  
  var currentWorkout: Workout {
    return completedWorkouts.last!.workout
  }
  
  func start(){
    defaults.setObject(NSDate(), forKey: "startTime")
    defaults.setObject(nextWorkout.duration, forKey: "duration")
    completedWorkouts.append(CompletedWorkout(workout: nextWorkout, completedOn: NSDate()))
    newlyCompletedWorkoutHasNotBeenShown = true
    publishNewWorkout()
  }
  
  func publishNewWorkout() {
    
    var lastWorkoutName = String()
    
    if let lastWorkout = completedWorkouts.last {
      lastWorkoutName = lastWorkout.workout.name
    }
    
    while lastWorkoutName == nextWorkout.name {
      let randomindex = Int(arc4random_uniform(UInt32(workouts.count)))
      nextWorkout = workouts[randomindex]
    }
  }
  
  func removeLastWorkout(){
    if !completedWorkouts.isEmpty {
      nextWorkout = completedWorkouts.removeLast().workout
    }
  }
}