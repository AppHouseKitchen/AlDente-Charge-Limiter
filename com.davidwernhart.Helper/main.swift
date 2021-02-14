//
//  main.swift
//  com.davidwernhart.Helper
//
//  Created by David Wernhart on 10.02.20.
//  Copyright © 2020 David Wernhart. All rights reserved.
//

import Foundation
import AppKit

final class HelperDelegate: NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: HelperToolProtocol.self)
        newConnection.exportedObject = HelperTool.instance
        newConnection.resume()
        return true
    }
}

let delegate = HelperDelegate()
let listener = NSXPCListener(machServiceName: "com.davidwernhart.Helper.mach")
listener.delegate = delegate
listener.resume()
var hasChecked = false
Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
    let workspace = NSWorkspace.shared
    let applications = workspace.runningApplications
    var foundApp = false
    for app in applications {
        if(app.bundleIdentifier?.elementsEqual("com.davidwernhart.AlDente") == true){
            foundApp = true
        }
    }
    if(foundApp && hasChecked){
        hasChecked = false
    }
    else if(!foundApp && !hasChecked){
        hasChecked = true
        HelperTool.instance.reset()
        exit(0)
    }
}
RunLoop.current.run()
