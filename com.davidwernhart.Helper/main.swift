//
//  main.swift
//  com.davidwernhart.Helper
//
//  Created by David Wernhart on 10.02.20.
//  Copyright © 2020 David Wernhart. All rights reserved.
//

import Foundation

class HelperDelegate: NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: HelperToolProtocol.self)
        newConnection.exportedObject = HelperTool()
        newConnection.resume()
        return true
    }
}

let delegate = HelperDelegate()
let listener = NSXPCListener(machServiceName: "com.davidwernhart.Helper.mach")
listener.delegate = delegate
listener.resume()
RunLoop.current.run()

