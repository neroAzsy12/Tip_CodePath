//
//  SettingViewControllerHelper.swift
//  tip
//
//  Created by Azael Zamora on 8/12/20.
//  Copyright © 2020 Codepath. All rights reserved.
//  This file helps with storing and loading the defaults that are set in settings
//  As well as remembering the bill amount within 10 minutes

import Foundation

// for loading default tip value
private let defaultTipKey: String = "defaultTip"

// for loading default split amount
private let defaultSplitGroupKey: String = "defaultSplit"

// for loading light or dark mode
private let defaultLightDarkModeIndex: String = "mode"

// to check if its been < 10 minutes since the app was used
private let previousLoadKey: String = "previousLoad"

// for storing the bill amount
private let billKey: String = "totalBill"

struct SettingViewControllerHelper {
    
    // default tip functions
    static func setDefaultTip(defaultTip: Double){
        let defaults = UserDefaults.standard
        defaults.set(defaultTip, forKey: defaultTipKey)
        
        defaults.synchronize()
    }
    
    static func getDefaultTip() -> Double {
        let defaults = UserDefaults.standard
        return defaults.double(forKey: defaultTipKey)
    }
    
    // default split functions
    static func setDefaultSplit(split: Int){
        let defaults = UserDefaults.standard
        defaults.set(split, forKey: defaultSplitGroupKey)
        
        defaults.synchronize()
    }
    
    static func getDefaultSplit() -> Int {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: defaultSplitGroupKey)
    }
    
    // default light dark mode functions
    static func setDefaultLightDarkIndex(lightDark: String){
        let defaults = UserDefaults.standard
        defaults.set(lightDark, forKey: defaultLightDarkModeIndex)
        
        defaults.synchronize()
    }
    
    static func getDefaultLightDarkIndex() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: defaultLightDarkModeIndex) ?? "light mode"
    }
    
    // for loading previous bill amount value
    static func setBill(billValue: Double){
        let defaults = UserDefaults.standard
        defaults.set(billValue, forKey: billKey)
        
        defaults.synchronize()
    }
    
    static func getBill() -> Double {
        let defaults = UserDefaults.standard
        return defaults.double(forKey: billKey)
    }
    
    // for loading previous bill amount if < 10 minutes
    static func setPreviousLoad() {
        let defaults = UserDefaults.standard
        defaults.set(NSDate(), forKey: previousLoadKey)
        
        defaults.synchronize()
    }
    
    static func getPreviousLoad() -> NSDate! {
        let defaults = UserDefaults.standard
        let date = defaults.object(forKey: previousLoadKey) as? NSDate
        
        return date
    }
    
}
