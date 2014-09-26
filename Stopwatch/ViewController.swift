//
//  ViewController.swift
//  Stopwatch
//
//  Created by Brad Kurtz on 9/25/14.
//  Copyright (c) 2014 Atomicat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    @IBAction func resetButton(sender: UIButton) {
        seconds = 0
        minutes = 0
        hours = 0
        
        timer?.invalidate()
        timerRunning = false
        setTimerText()
        formatTime()
    }

    var seconds = 0
    var minutes = 0
    var hours = 0
    var timerRunning = false
    
    var timer: NSTimer?
    
    @IBAction func toggleTimer(sender: UIButton) {
        timerRunning = !timerRunning
        
        if timerRunning {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("incSeconds"), userInfo: nil, repeats: true)
        } else {
            timer?.invalidate()
        }
        
        setTimerText()
    }
    
    func incSeconds() {
        seconds++
        formatTime()
    }
    
    func formatTime() {
        if seconds >= 60 {
            minutes++
            seconds %= seconds
        }
        if minutes >= 60 {
            hours++
            minutes %= minutes
        }

        let fMin = formatDoubleDigits(minutes)
        let fSec = formatDoubleDigits(seconds)
        
        time.text = "\(hours):\(fMin):\(fSec)"
    }
    
    func formatDoubleDigits(unit: Int) -> String {
        return unit < 10 ? "0\(unit)" : "\(unit)"
    }
    
    func setTimerText() {
        var text = timerRunning ? "Stop" : "Start"
        timerButton.setTitle(text, forState: .Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setTimerText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

