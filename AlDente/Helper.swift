//
//  Helper.swift
//  AlDente
//
//  Created by David Wernhart on 14.02.20.
//  Copyright © 2020 David Wernhart. All rights reserved.
//

import Cocoa
import SwiftUI
import ServiceManagement
import Foundation

protocol HelperDelegate {
    func OnMaxBatRead(value: UInt8)
}

class Helper{
    
    static let instance = Helper()
    
    public var delegate: HelperDelegate?
    
//    var receiveMessage = "" {
//            didSet {
//                DispatchQueue.main.async {
//                    print(self.receiveMessage)
//    //                if self.receiveMessage.isEmpty {
//    //                    self.clearButton.isEnabled = false
//    //                } else {
//    //                    self.clearButton.isEnabled = true
//    //                }
//                }
//            }
//        }
        
    lazy var helperToolConnection: NSXPCConnection = {
        let connection = NSXPCConnection(machServiceName: "com.davidwernhart.Helper.mach", options: .privileged)
        connection.remoteObjectInterface = NSXPCInterface(with: HelperToolProtocol.self)
           
        connection.resume()
        return connection
    }()
    
    @objc func installHelper() {
        print("trying to install helper!")
        var status = noErr
        let helperID = "com.davidwernhart.Helper" as CFString // Prefs.helperID as CFString

        var authItem = kSMRightBlessPrivilegedHelper.withCString {
            AuthorizationItem(name: $0, valueLength: 0, value: nil, flags: 0)
        }
        var authRights = withUnsafeMutablePointer(to: &authItem) {
            AuthorizationRights(count: 1, items: $0)
        }
        let authFlags: AuthorizationFlags = [.interactionAllowed, .preAuthorize, .extendRights]
        var authRef: AuthorizationRef?
        status = AuthorizationCreate(&authRights, nil, authFlags, &authRef)
        if status != errAuthorizationSuccess {
            print(SecCopyErrorMessageString(status, nil) ?? "")
            print("Error: \(status)")
        }
        var error: Unmanaged<CFError>?
        SMJobBless(kSMDomainSystemLaunchd, helperID, authRef, &error)
        if let e = error?.takeRetainedValue() {
            print("Domain: ", CFErrorGetDomain(e) ?? "")
            print("Code: ", CFErrorGetCode(e))
            print("UserInfo: ", CFErrorCopyUserInfo(e) ?? "")
            print("Description: ", CFErrorCopyDescription(e) ?? "")
            print("Reason: ", CFErrorCopyFailureReason(e) ?? "")
            print("Suggestion: ", CFErrorCopyRecoverySuggestion(e) ?? "")
        }
    }


    @objc func writeMaxBatteryCharge(setVal: UInt8){
        SMCWriteByte(key: "BCLM", value: setVal)
        

    }
    
    @objc func readMaxBatteryCharge(){
        SMCReadByte(key:"BCLM",withReply: { (value) in
            print(String(value))
            self.delegate?.OnMaxBatRead(value: value)
        })
    }

    @objc func checkHelperVersion() {
        print("checking helper version")
        if let helper = helperToolConnection.remoteObjectProxyWithErrorHandler({ (error) in
            let e = error as NSError
            print("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")
            self.installHelper()
            //self.receiveMessage.append("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")
        }) as? HelperToolProtocol {            
            helper.getVersion(withReply: { (version) in
                print("helperVersion:", helperVersion, " version from helper:",version)
                if(!helperVersion.elementsEqual(version)){
                    self.installHelper()
                }
                //self.receiveMessage.append("Version: \(version)\n")
            })
        }
    }

    @objc func SMCReadByte(key:String, withReply reply: @escaping (UInt8) -> Void){
        if let helper = helperToolConnection.remoteObjectProxyWithErrorHandler({ (error) in
            let e = error as NSError
            print("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")
            //self.receiveMessage.append("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")
        }) as? HelperToolProtocol {
            helper.readSMCByte(key: key) { (value) in
                reply (value)
            }
        }
    }

    @objc func SMCWriteByte(key:String,value:UInt8){
        if let helper = helperToolConnection.remoteObjectProxyWithErrorHandler({ (error) in
            let e = error as NSError
            print("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")
            //self.receiveMessage.append("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")
        }) as? HelperToolProtocol {
            helper.setSMCByte(key: key,value: value)
        }
    }
}
