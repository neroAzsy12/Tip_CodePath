//
//  ViewController.swift
//  tip
//
//  Created by Azael Zamora on 8/10/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let defaults: UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var billAmount: UITextField!
    
    @IBOutlet weak var controlTip: UISegmentedControl!
    
    @IBOutlet weak var splitSlider: UISlider!
    
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var totalSplitLabel: UILabel!
    
    // label for the total amount
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    // label for the total
    @IBOutlet weak var totalLabel: UILabel!
    
    // label for tip Label
    @IBOutlet weak var tipLabelT: UILabel!
    
    // label for tip
    @IBOutlet weak var tipLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalAmountLabel.text = setLocalCurrency(value: 0.0)
        initializeSplitValue()
        controlTip.selectedSegmentIndex = initializeTipValue()
        loadBillAmount()
        
        calculateTip()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controlTip.selectedSegmentIndex = initializeTipValue()
        setDarkLightMode()
        initializeSplitValue()
        
        calculateTip()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SettingViewControllerHelper.setBill(billValue: amountOfBill())
        SettingViewControllerHelper.setPreviousLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func amountOfBill() -> Double {
        return NSString(string: billAmount.text!).doubleValue
    }
    
    private func loadBillAmount() {
        let now = NSDate()
        let previousLoad = SettingViewControllerHelper.getPreviousLoad()
        var amount = ""
        
        if previousLoad != nil && now.timeIntervalSince(previousLoad! as Date) / 60 < 10 {
            if(SettingViewControllerHelper.getBill() > 0.0){
                amount = String(format: "%.2f", SettingViewControllerHelper.getBill())
            }
        }
        billAmount.text = amount
        billAmount.becomeFirstResponder()
    }
    
    // used when tapping elsewhere on the screen
    @IBAction func onTap(_ sender: Any) {
        //print("hello")
        view.endEditing(true)
    }
    
    // initializes the tip index
    private func initializeTipValue() -> Int {
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
    
    @IBAction func splitEdit(_ sender: UISlider) {
        splitLabel.text = Int(sender.value).description
        calculateTip()
    }
    
    // initializes the split value
    private func initializeSplitValue() {
        var splitVal = SettingViewControllerHelper.getDefaultSplit()
        
        if splitVal == 0 {
            splitVal = 0
        }
        
        splitSlider.value = Float(splitVal)
        splitEdit(splitSlider)
    }
    
    // sets the amount in the currency of the region
    private func setLocalCurrency(value: Double) -> String {
        let formatAmount = NumberFormatter()
        formatAmount.numberStyle = .currency
        formatAmount.locale = NSLocale.current
        
        return formatAmount.string(from: NSNumber(value: value))!
    }
    
    // set light or dark mode
    private func setDarkLightMode() {
        let darkLight = SettingViewControllerHelper.getDefaultLightDarkIndex()
        
        if darkLight == "light mode" {
            view.backgroundColor = UIColor.white
            
            billAmount.textColor = UIColor.black
            billAmount.keyboardAppearance = UIKeyboardAppearance.light
            
            totalAmountLabel.textColor = UIColor.black
            totalLabel.textColor = UIColor.black
            
            splitLabel.textColor = UIColor.black
            totalSplitLabel.textColor = UIColor.black
            
            tipLabelT.textColor = UIColor.black
            tipLabel.textColor = UIColor.black
            
        }else {
           view.backgroundColor = UIColor(hex: 0x1F2124, alpha: 1.0)
            
            billAmount.textColor = UIColor.white
            billAmount.keyboardAppearance = UIKeyboardAppearance.dark
            
            totalAmountLabel.textColor = UIColor.white
            totalLabel.textColor = UIColor.white
            
            splitLabel.textColor = UIColor.white
            totalSplitLabel.textColor = UIColor.white
            
            tipLabelT.textColor = UIColor.white
            tipLabel.textColor = UIColor.white
        }
    }
    
    private func calculateTip() {
        //let total =
        let total = amountOfBill()
        
        let tips = [0.15, 0.18, 0.2]
        let tip = total * tips[controlTip.selectedSegmentIndex]
        
        let totalBill = total + tip
        
        let splits = totalBill / Double(splitSlider.value)
        
        totalAmountLabel.text = setLocalCurrency(value: totalBill)
        totalSplitLabel.text = setLocalCurrency(value: splits)
        tipLabel.text = setLocalCurrency(value: tip)
    }
    
    
    @IBAction func billValueChanges(_ sender: AnyObject) {
        calculateTip()
    }
}

/*
let calImage = UIImageView(image: UIImage(named: "CalculatorLogo"))
let splashView = UIView()

override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.navigationController?.navigationBar.isHidden = true
    splashView.backgroundColor = UIColor.white
    view.addSubview(splashView)
    splashView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    
    calImage.contentMode = .scaleAspectFill
    splashView.addSubview(calImage)
    calImage.frame = CGRect(x: splashView.frame.midX - 50, y: splashView.frame.midY - 50, width: 100, height: 100)
}


override var preferredStatusBarStyle: UIStatusBarStyle{
    return UIStatusBarStyle.default
}

override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
        self.scaleDownAnimation()
    }
    
}

func scaleDownAnimation() {
    UIView.animate(withDuration: 2.5, animations: {
        self.calImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }) { ( success ) in
        self.scaleUpAnimation()
    }
}

func scaleUpAnimation() {
    UIView.animate(withDuration: 1.5, delay: 0.1, options: .curveEaseIn,
                   animations: {
                    self.calImage.transform = CGAffineTransform(scaleX: 20, y: 20)
                    self.calImage.alpha = 0
    }) { (success ) in
        self.removeSplashScreen()
        self.navigationController?.navigationBar.isHidden = false
    }
}

func removeSplashScreen(){
    splashView.removeFromSuperview()
}


override func viewWillAppear(_ animated: Bool) {
    billAmount.becomeFirstResponder()
}
*/
