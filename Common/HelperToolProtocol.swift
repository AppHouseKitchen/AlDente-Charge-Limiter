//
//  HelperToolProtocol.swift
//  AlDente
//
//  Created by David Wernhart on 13.02.20.
//  Copyright © 2020 David Wernhart. All rights reserved.
//

import Foundation
import IOKit.pwr_mgt

let helperVersion: String = "10" //for some reason the integrated version check does not work, so I use this one

@objc(HelperToolProtocol) protocol HelperToolProtocol {
//protocol HelperToolProtocol {
    func getVersion(withReply reply: @escaping (String) -> Void)

    //TODO: more functions for other data types, altough this is sufficient for battery max charge level
    func setSMCByte(key: String, value: UInt8)
    func readSMCByte(key: String, withReply reply: @escaping (UInt8) -> Void)
    func readSMCUInt32(key: String, withReply reply: @escaping (UInt32) -> Void)
    
    func createAssertion(assertion:String, withReply reply: @escaping (IOPMAssertionID) -> Void)
    func releaseAssertion(assertionID:IOPMAssertionID)
    func setResetVal(key:String, value: UInt8)

}
