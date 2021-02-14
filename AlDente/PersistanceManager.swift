//
//  PersistanceManager.swift
//  AlDente
//
//  Created by David Wernhart on 07.02.21.
//  Copyright © 2021 David Wernhart. All rights reserved.
//

import Foundation

class PersistanceManager{
    static let instance = PersistanceManager()
    
    public var launchOnLogin: Bool?
    public var chargeVal: Int?
    public var oldKey: Bool = false
    
    public func load(){
        launchOnLogin = UserDefaults.standard.bool(forKey: "launchOnLogin")
        oldKey = UserDefaults.standard.bool(forKey: "oldKey")
        chargeVal = UserDefaults.standard.integer(forKey: "chargeVal")
    }
    
    public func save(){
        UserDefaults.standard.set(launchOnLogin, forKey: "launchOnLogin")
        UserDefaults.standard.set(chargeVal, forKey: "chargeVal")
        UserDefaults.standard.set(oldKey, forKey: "oldKey")
    }
}
