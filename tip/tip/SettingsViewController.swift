//
//  SettingsViewController.swift
//  tip
//
//  Created by Azael Zamora on 8/10/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let defaults: UserDefaults = UserDefaults.standard
    
    // tip segment controller
    @IBOutlet weak var tipController: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    
    // dark mode controller
    @IBOutlet weak var DarkMode: UISegmentedControl!
    @IBOutlet weak var darkModeLabel: UILabel!
    
    // split slidder
    @IBOutlet weak var splitSlide: UISlider!
    @IBOutlet weak var defaultSplitLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tipController.selectedSegmentIndex = defaultTip()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tipController.selectedSegmentIndex = defaultTip()
        setDefaultSplit()
        changeScreenMode()
    }
    
    // loads the default tip value
    private func defaultTip() -> Int {
        switch SettingViewControllerHelper.getDefaultTip() {
        case 0.15:
            return 0
        
        case 0.18:
            return 1
            
        case 0.2:
            return 2
        
        default:
            return 0
        }
    }
    
    // this will constantly update the default tip percentage should there be any changes
    @IBAction func tipChanges(_ sender: Any) {
        SettingViewControllerHelper.setDefaultTip(defaultTip: setTip())
    }
    
    // returns the value at the selected segment index
    private func setTip() -> Double {
        let tipValues = [0.15, 0.18, 0.2]
        return tipValues[tipController.selectedSegmentIndex]
    }
    
    // this is when the split slidder value changes
    @IBAction func splitValueChanges(_ sender: UISlider) {
        let splitNum = Int(sender.value)
        splitLabel.text = splitNum.description
        
        SettingViewControllerHelper.setDefaultSplit(split: splitNum)
    }
    
    private func setDefaultSplit() {
        var split = SettingViewControllerHelper.getDefaultSplit()
        
        if split == 0 {
            split = 1
        }
        
        splitSlide.value = Float(split)
        splitValueChanges(splitSlide)
    }
    
    // light/dark mode
    @IBAction func darkLightMode(_ sender: Any) {
        let dark_index = DarkMode.selectedSegmentIndex
        print(dark_index)
        
        switch dark_index {
        case 0:
            print("light mode")
            
        case 1:
            print("dark mode")
        
        default:
            print("unknown theme")
        }
        
        setLightDark(index: dark_index)
    }
    
    /*
    private func setLightDark(index: Int) -> String {
        let modes = ["light mode", "dark mode"]
        return modes[index]
    }
    */
    private func setLightDark(index: Int) {
        let modes = ["light mode", "dark mode"]
        SettingViewControllerHelper.setDefaultLightDarkIndex(lightDark: modes[index])
        
        changeScreenMode()
    }
    
    private func changeScreenMode() {
        let lightDark = SettingViewControllerHelper.getDefaultLightDarkIndex()
        
        if lightDark == "light mode" {
            DarkMode.selectedSegmentIndex = 0
            view.backgroundColor = UIColor.white
            tipLabel.textColor = UIColor.black
            darkModeLabel.textColor = UIColor.black
            splitLabel.textColor = UIColor.black
            defaultSplitLabel.textColor = UIColor.black
            
            /*
            DarkMode.tintColor = UIColor(hex: 0xFFFFFF, alpha: 1.0)
            DarkMode.backgroundColor = UIColor(hex: 0xEEEEEF, alpha: 1.0)
            */
        }else{
            DarkMode.selectedSegmentIndex = 1
            view.backgroundColor = UIColor(hex: 0x1F2124, alpha: 1.0)
            
            tipLabel.textColor = UIColor.white
            darkModeLabel.textColor = UIColor.white
            splitLabel.textColor = UIColor.white
            defaultSplitLabel.textColor = UIColor.white
            
            /*
            DarkMode.tintColor = UIColor(hex: 0x7E9FFF, alpha: 1.0)
            DarkMode.backgroundColor = UIColor(hex: 0x8B8B90, alpha: 1.0)
             */
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0){
        let r = CGFloat( (hex >> 16) & 0x000000ff) / 255
        let g = CGFloat( (hex >> 8) & 0x000000ff) / 255
        let b = CGFloat( (hex) & 0x000000ff) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
