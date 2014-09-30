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
        hundredth = 0
        seconds = 0
        minutes = 0
        
        timer?.invalidate()
        timerRunning = false
        setTimerText()
        formatTime()
    }

    var hundredth = 0
    var seconds = 0
    var minutes = 0
    var timerRunning = false
    
    var timer: NSTimer?
    
    @IBAction func toggleTimer(sender: UIButton) {
        timerRunning = !timerRunning
        
        if timerRunning {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("incrementTime"), userInfo: nil, repeats: true)
        } else {
            timer?.invalidate()
        }
        
        setTimerText()
    }
    
    func incrementTime() {
        hundredth++
        formatTime()
    }
    
    func formatTime() {
        if hundredth >= 100 {
            seconds++
            hundredth %= hundredth
        }
        
        if seconds >= 60 {
            minutes++
            seconds %= seconds
        }

        let fMin = formatDoubleDigits(minutes)
        let fSec = formatDoubleDigits(seconds)
        let fHundredth = formatDoubleDigits(hundredth)
        
        time.text = "\(fMin):\(fSec).\(fHundredth)"
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

