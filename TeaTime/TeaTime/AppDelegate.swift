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

    func applicationDidFinishLaunching(aNotification: NSNotification)
    {
        NSApplication.sharedApplication().hide(nil)

        NSTimer.scheduledTimerWithTimeInterval(teaTimeSeconds,
                target: self,
                selector: Selector("teaReady:"),
                userInfo: nil,
                repeats: false)
    }

    func applicationWillTerminate(aNotification: NSNotification)
    {
    }

    func teaReady(timer: NSTimer)
    {
        NSApplication.sharedApplication().activateIgnoringOtherApps(true)

        let alert = NSAlert();
        alert.messageText = "Tee ist fertig!"
        alert.runModal()

        NSApplication.sharedApplication().terminate(nil)
    }

}

