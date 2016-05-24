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

}
