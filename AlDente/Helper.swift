//
//  Helper.swift
//  AlDente
//
//  Created by David Wernhart on 14.02.20.
//  Copyright © 2020 David Wernhart. All rights reserved.
//

import Foundation
import ServiceManagement
import IOKit.pwr_mgt

protocol HelperDelegate {
    func OnMaxBatRead(value: UInt8)
    func updateStatus(status:String)
}

final class Helper {

    static let instance = Helper()

    public var delegate: HelperDelegate?
    
    private var key: String?
    
    private var preventSleepID: IOPMAssertionID?
    
    public var appleSilicon:Bool?
    public var chargeInhibited: Bool = false
    public var isInitialized:Bool = false
    
    public var statusString:String = ""


    lazy var helperToolConnection: NSXPCConnection = {
        let connection = NSXPCConnection(machServiceName: "com.davidwernhart.Helper.mach", options: .privileged)
        connection.remoteObjectInterface = NSXPCInterface(with: HelperToolProtocol.self)

        connection.resume()
        return connection
    }()

    func setPlatformKey() {
        let s:String! = ProcessInfo.init().machineHardwareName
        if(s != nil){
            if(s.elementsEqual("x86_64")){
                print("intel cpu!")
                appleSilicon = false;
            }
            else if(s.elementsEqual("arm64")){
                print("arm cpu!")
                appleSilicon = true;
            }
            
        }
    }
    func setStatusString(){
        checkCharging()
        var sleepDisabled:Bool = !(preventSleepID == nil)
        statusString = ""
        if(PersistanceManager.instance.oldKey){
            statusString = "BCLM Key Mode. Final charge value can differ by up to 5%"
        }
        else{
            statusString = "Charge Inhibit: "+String(chargeInhibited)+" | Prevent Sleep: "+String(sleepDisabled)+" | Helper v"+String(helperVersion)+": \(self.isInitialized ? "found" : "not found")"
        }
        
        
        self.delegate?.updateStatus(status: statusString)
    }

    
    func enableSleep(){
        if(self.preventSleepID != nil){
            print("RELEASING PREVENT SLEEP ASSERTION WITH ID: ",preventSleepID!)
            releaseAssertion(assertionId: self.preventSleepID!)
            self.preventSleepID = nil
        }
    }
    
    func disableSleep(){
        createAssertion(assertion: kIOPMAssertionTypePreventSystemSleep){ id in
            if(self.preventSleepID == nil){
                print("PREVENT SLEEP ASSERTION CREATED! ID: ",id)
                self.preventSleepID = id
            }
        }
    }
    
    func enableCharging(){
        if(appleSilicon!){
            SMCWriteByte(key: "CH0B", value: 00)
        }
        SMCWriteByte(key: "CH0B", value: 00)
        self.chargeInhibited = false
        
    }
    
    func disableCharging(){
        if(appleSilicon!){
            SMCWriteByte(key: "CH0B", value: 02)
        }
        SMCWriteByte(key: "CH0B", value: 02)
        self.chargeInhibited = true
        
    }
    
    func checkCharging(){
        Helper.instance.SMCReadUInt32(key: "CH0B") { value in
            self.chargeInhibited = !(value == 00)
            print("CHARGE INHIBITED: "+String(self.chargeInhibited))
        }
        if(PersistanceManager.instance.oldKey){
            Helper.instance.readMaxBatteryCharge()
        }

    }
    
    func getChargingInfo(withReply reply: (String,Int,Bool,Int) -> Void){
        let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue() as Array
        let info = IOPSGetPowerSourceDescription(snapshot, sources[0]).takeUnretainedValue() as! [String: AnyObject]

        if let name = info[kIOPSNameKey] as? String,
            let capacity = info[kIOPSCurrentCapacityKey] as? Int,
            let isCharging = info[kIOPSIsChargingKey] as? Bool,
            let max = info[kIOPSMaxCapacityKey] as? Int {
            reply(name,capacity,isCharging,max)
        }
    }
    
    func getSMCCharge(withReply reply: @escaping (Float)->Void){
        Helper.instance.SMCReadUInt32(key: "BRSC") { value in
            let smcval = Float(value >> 16)
            reply(smcval)
        }
    }
    
    @objc func createAssertion(assertion: String, withReply reply: @escaping (IOPMAssertionID) -> Void){
        let helper = helperToolConnection.remoteObjectProxyWithErrorHandler {
            let e = $0 as NSError
            print("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")
        } as? HelperToolProtocol

        helper?.createAssertion(assertion: assertion, withReply: { id in
            reply(id)
        })
    }
    
    @objc func releaseAssertion(assertionId: IOPMAssertionID){
        let helper = helperToolConnection.remoteObjectProxyWithErrorHandler {
            let e = $0 as NSError
            print("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")
        } as? HelperToolProtocol

        helper?.releaseAssertion(assertionID: assertionId)
    }
    
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
        
        if(error == nil){
            print("helper installed successfully!")
            restart()
        }
    }
    
    func restart(){
        let url = URL(fileURLWithPath: Bundle.main.resourcePath!)
        let path = url.deletingLastPathComponent().deletingLastPathComponent().absoluteString
        let task = Process()
        task.launchPath = "/usr/bin/open"
        task.arguments = [path]
        task.launch()
        exit(0)
    }
    
    @objc func setResetValues(){
        let helper = helperToolConnection.remoteObjectProxyWithErrorHandler {
            let e = $0 as NSError
            print("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")

        } as? HelperToolProtocol
        
        helper?.setResetVal(key: "CH0B", value: 00)
    }

    @objc func writeMaxBatteryCharge(setVal: UInt8) {
        SMCWriteByte(key: "BCLM", value: setVal)

    }

    @objc func readMaxBatteryCharge() {
        SMCReadByte(key: "BCLM") { value in
            print("OLD KEY MAX CHARGE: "+String(value))
            self.delegate?.OnMaxBatRead(value: value)
        }
    }
    
    @objc func enableCharging(enabled: Bool) {
        if(enabled){
            SMCWriteByte(key: "CH0B", value: 00)
        }
        else{
            SMCWriteByte(key: "CH0B", value: 02)
        }

    }

    @objc func checkHelperVersion(withReply reply: @escaping (Bool) -> Void) {
        print("checking helper version")
        let helper = helperToolConnection.remoteObjectProxyWithErrorHandler {
            let e = $0 as NSError
            print("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")
            reply(false)
            return()

        } as? HelperToolProtocol

        helper?.getVersion { version in
            print("helperVersion:", helperVersion, " version from helper:", version)
            if !helperVersion.elementsEqual(version) {
                reply(false)
                return()            }
            else{
                self.isInitialized = true
                reply(true)
                return()
            }
        }
    }

    @objc func SMCReadByte(key: String, withReply reply: @escaping (UInt8) -> Void) {
        let helper = helperToolConnection.remoteObjectProxyWithErrorHandler {
            let e = $0 as NSError
            print("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")

        } as? HelperToolProtocol

        helper?.readSMCByte(key: key) {
            reply($0)
        }
    }
    
    @objc func SMCReadUInt32(key: String, withReply reply: @escaping (UInt32) -> Void) {
        let helper = helperToolConnection.remoteObjectProxyWithErrorHandler {
            let e = $0 as NSError
            print("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")

        } as? HelperToolProtocol

        helper?.readSMCUInt32(key: key) {
            reply($0)
        }
    }

    @objc func SMCWriteByte(key: String, value: UInt8) {
        let helper = helperToolConnection.remoteObjectProxyWithErrorHandler {
            let e = $0 as NSError
            print("Remote proxy error \(e.code): \(e.localizedDescription) \(e.localizedRecoverySuggestion ?? "---")")

        } as? HelperToolProtocol

        helper?.setSMCByte(key: key, value: value)
    }
}
