//
//  HelperTool.swift
//  com.davidwernhart.Helper
//
//  Created by David Wernhart on 13.02.20.
//  Copyright © 2020 David Wernhart. All rights reserved.
//

import Foundation

class HelperTool: NSObject, HelperToolProtocol {
    func getVersion(withReply reply: (String) -> Void) {
//        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString" as String) as? String ?? "(unknown version)"
//        let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String ?? "(unknown build)"
//        reply("v\(version) (\(build))")
        reply(helperVersion)

    }

    func setSMCByte(key: String, value: UInt8) {
        do {
            try SMCKit.open()
        } catch {
            print(error)
            exit(EX_UNAVAILABLE)
        }

        let smcKey = SMCKit.getKey(key, type: DataTypes.UInt8)
        let bytes: SMCBytes = (value, UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
        UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
        UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
        UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
        UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0), UInt8(0),
        UInt8(0), UInt8(0))

        _ = try? SMCKit.writeData(smcKey, data: bytes)
    }

    func readSMCByte(key: String, withReply reply: @escaping (UInt8) -> Void) {
        do {
            try SMCKit.open()
        } catch {
            print(error)
            exit(EX_UNAVAILABLE)
        }

        let smcKey = SMCKit.getKey(key, type: DataTypes.UInt8)
        do {
            let status = try SMCKit.readData(smcKey).0
            reply(status)
        } catch {
            reply(0)
        }
    }
}
