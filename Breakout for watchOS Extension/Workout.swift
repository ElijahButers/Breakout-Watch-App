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

@objc(Workout)
class Workout: NSObject, NSCoding {
  let name: String
  let instructions: String
  let duration: NSTimeInterval
  var imageName: String {
    // no spaces, all lower case
    return name.stringByReplacingOccurrencesOfString(" ", withString: "").lowercaseString
  }
  
  init(name: String, instructions: String, duration: NSTimeInterval) {
    self.name = name
    self.instructions = instructions
    self.duration = duration
    super.init()
  }
  
  required init?(coder: NSCoder) {
    name = coder.decodeObjectForKey("name")! as! String
    instructions = coder.decodeObjectForKey("instructions")! as! String
    duration = coder.decodeObjectForKey("duration")! as! NSTimeInterval
    super.init()
  }
  
  func encodeWithCoder(coder: NSCoder) {
    coder.encodeObject(name, forKey: "name")
    coder.encodeObject(instructions, forKey: "instructions")
    coder.encodeObject(duration, forKey: "duration")
  }
  
}

let workouts = [
  Workout(name: "High knees", instructions: "Bring your knees up to your chest as high as you can, pumping your arms as quickly as you can. Try to land on the balls of your feet as you run and switch legs as fast as you can.", duration: 30),
  Workout(name: "Squats", instructions: "From standing, sit back and down like you're sitting into an imaginary chair until your thighs are  parallel to the floor. Push through your heels to bring yourself back to the starting position.", duration: 30),
  Workout(name: "Plank", instructions: "From pushup position, bend your elbows 90 degrees and rest your weight on your forearms. Your elbows should be directly beneath your shoulders, and your body should form a straight line from your head to your feet.", duration: 30),
  Workout(name: "Lunges", instructions: "Stand with your feet together, one heel lifted. Step that leg back and lower into a deep lunge, reaching your arms down to the ground on either side of your right foot. Press through your opposite foot to stand back up.", duration: 30)
]