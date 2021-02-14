//
//  AppDelegate.swift
//  AlDente
//
//  Created by David Wernhart on 09.02.20.
//  Copyright © 2020 David Wernhart. All rights reserved.
//

import AppKit
import SwiftUI
import LaunchAtLogin
import Foundation
import IOKit.ps
import IOKit.pwr_mgt

extension ProcessInfo {
        /// Returns a `String` representing the machine hardware name or nil if there was an error invoking `uname(_:)` or decoding the response.
        ///
        /// Return value is the equivalent to running `$ uname -m` in shell.
        var machineHardwareName: String? {
                var sysinfo = utsname()
                let result = uname(&sysinfo)
                guard result == EXIT_SUCCESS else { return nil }
                let data = Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN))
                guard let identifier = String(bytes: data, encoding: .ascii) else { return nil }
                return identifier.trimmingCharacters(in: .controlCharacters)
        }
}

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {

    //var window: NSWindow!
    var statusBarItem: NSStatusItem!
    var popover: NSPopover!
    
    func applicationWillTerminate(_ aNotification: Notification) {
        Helper.instance.enableSleep()
        Helper.instance.enableCharging()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let contentView = ContentView()

        // Create the popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 600)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover

        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        statusBarItem.button?.image = NSImage(named: "menubaricon")!
        statusBarItem.button?.action = #selector(togglePopover(_:))
        
        Helper.instance.setPlatformKey()

        Helper.instance.checkHelperVersion{(foundHelper) in
            if(foundHelper){
                print("helper found!")
            }
            else{
                Helper.instance.installHelper()
            }
        }
        
        LaunchAtLogin.isEnabled = true
        SMCPresenter.shared.loadValue()
        
        Helper.instance.checkCharging()
        
        var actionMsg:String?

        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            if(Helper.instance.isInitialized){
                Helper.instance.getChargingInfo { (Name, Capacity, IsCharging, MaxCapacity) in
                    
                    
                    if(!PersistanceManager.instance.oldKey){
                        if(Capacity < SMCPresenter.shared.value){
                            actionMsg = "NEED TO CHARGE"
                            if(Helper.instance.chargeInhibited){
                                Helper.instance.enableCharging()
                            }
                            Helper.instance.disableSleep()
 
                        }
                        else{
                            actionMsg = "IS PERFECT"
                            if(!Helper.instance.chargeInhibited){
                                Helper.instance.disableCharging()
                            }
                            Helper.instance.enableSleep()
                            
                        }
                        print("TARGET: ",SMCPresenter.shared.value,
                              " CURRENT: ",String(Capacity),
                              " ISCHARGING: ",String(IsCharging),
                              " CHARGE INHIBITED: ",String(Helper.instance.chargeInhibited),
                              " ACTION: ",actionMsg!)
                    }
                    else{
                        print("BCLM MODE ENABLED")
                    }
                    
                    

                }
                DispatchQueue.main.async {
                    Helper.instance.setStatusString()
                }
                
            }
        }
        
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        popover.contentViewController?.view.window?.becomeKey()

        Helper.instance.setStatusString()
        if let button = self.statusBarItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }

}
