//
//  AppDelegate.swift
//  TeaTime
//
//  Created by Rainer Schmid on 26.10.14.
//  Copyright (c) 2014 Rainer Schmid. All rights reserved.
//

import Cocoa

let teaTimeSeconds: NSTimeInterval = 3 * 60

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    var countDownTimer: NSTimer!
    var statusItem: NSStatusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1) // -1 is NSVariableStatusItemLength
    var finishingTime: NSTimeInterval = 0

    func applicationDidFinishLaunching(aNotification: NSNotification)
    {
        NSApplication.sharedApplication().hide(nil)

        NSTimer.scheduledTimerWithTimeInterval(teaTimeSeconds,
                target: self,
                selector: Selector("teaReady:"),
                userInfo: nil,
                repeats: false)

        self.finishingTime = NSDate.timeIntervalSinceReferenceDate() + teaTimeSeconds
        self.countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,
            target: self,
            selector: Selector("countDown:"),
            userInfo: nil,
            repeats: true)
        self.countDown(self.countDownTimer)
    }

    func applicationWillTerminate(aNotification: NSNotification)
    {
    }

    func countDown(timer: NSTimer)
    {
        let timeLeft = Int(self.finishingTime - NSDate.timeIntervalSinceReferenceDate()) + 1
        let minutes = timeLeft / 60
        let seconds = timeLeft % 60
        self.statusItem.title = "☕️ \(minutes):\(seconds)"
    }

    func teaReady(timer: NSTimer)
    {
        self.countDownTimer.invalidate()
        self.statusItem.title = "☕️ fertig!"

        NSApplication.sharedApplication().activateIgnoringOtherApps(true)

        let alert = NSAlert();
        alert.messageText = "Tee ist fertig!"
        alert.runModal()

        NSApplication.sharedApplication().terminate(nil)
    }

}

