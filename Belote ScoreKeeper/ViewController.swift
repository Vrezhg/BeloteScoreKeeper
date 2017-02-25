//
//  ViewController.swift
//  Belote ScoreKeeper
//
//  Created by Vrezh Gulyan on 2/14/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController , GADInterstitialDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var team1: UITextField!
    @IBOutlet weak var team2: UITextField!
    
    @IBOutlet weak var row1col1: UITextField!
    @IBOutlet weak var row1col2: UITextField!
    @IBOutlet weak var row2col1: UITextField!
    @IBOutlet weak var row2col2: UITextField!
    @IBOutlet weak var row3col1: UITextField!
    @IBOutlet weak var row3col2: UITextField!
    @IBOutlet weak var row4col1: UITextField!
    @IBOutlet weak var row4col2: UITextField!
    @IBOutlet weak var row5col1: UITextField!
    @IBOutlet weak var row5col2: UITextField!
    @IBOutlet weak var row6col1: UITextField!
    @IBOutlet weak var row6col2: UITextField!
    @IBOutlet weak var row7col1: UITextField!
    @IBOutlet weak var row7col2: UITextField!
    @IBOutlet weak var row8col1: UITextField!
    @IBOutlet weak var row8col2: UITextField!
    @IBOutlet weak var row9col1: UITextField!
    @IBOutlet weak var row9col2: UITextField!
    @IBOutlet weak var row10col1: UITextField!
    @IBOutlet weak var row10col2: UITextField!
    @IBOutlet weak var row11col1: UITextField!
    @IBOutlet weak var row11col2: UITextField!
    @IBOutlet weak var row12col1: UITextField!
    @IBOutlet weak var row12col2: UITextField!
    @IBOutlet weak var row13col1: UITextField!
    @IBOutlet weak var row13col2: UITextField!
    @IBOutlet weak var row14col1: UITextField!
    @IBOutlet weak var row14col2: UITextField!
    @IBOutlet weak var row15col1: UITextField!
    @IBOutlet weak var row15col2: UITextField!
    @IBOutlet weak var row16col1: UITextField!
    @IBOutlet weak var row16col2: UITextField!
    @IBOutlet weak var row17col1: UITextField!
    @IBOutlet weak var row17col2: UITextField!
    @IBOutlet weak var row18col1: UITextField!
    @IBOutlet weak var row18col2: UITextField!
    @IBOutlet weak var row19col1: UITextField!
    @IBOutlet weak var row19col2: UITextField!
    @IBOutlet weak var row20col1: UITextField!
    @IBOutlet weak var row20col2: UITextField!
    @IBOutlet weak var row21col1: UITextField!
    @IBOutlet weak var row21col2: UITextField!
    @IBOutlet weak var row22col1: UITextField!
    @IBOutlet weak var row22col2: UITextField!
    @IBOutlet weak var row23col1: UITextField!
    @IBOutlet weak var row23col2: UITextField!
    @IBOutlet weak var row24col1: UITextField!
    @IBOutlet weak var row24col2: UITextField!
    @IBOutlet weak var row25col1: UITextField!
    @IBOutlet weak var row25col2: UITextField!
    @IBOutlet weak var row26col1: UITextField!
    @IBOutlet weak var row26col2: UITextField!
    @IBOutlet weak var row27col1: UITextField!
    @IBOutlet weak var row27col2: UITextField!
    @IBOutlet weak var row28col1: UITextField!
    @IBOutlet weak var row28col2: UITextField!
    @IBOutlet weak var row29col1: UITextField!
    @IBOutlet weak var row29col2: UITextField!
    @IBOutlet weak var row30col1: UITextField!
    @IBOutlet weak var row30col2: UITextField!
    
    
    var column1 : [UITextField?] = []
    var column2 : [UITextField] = []
    
    var tag : Int = 0 // tag for textFields
    var valueDidChange : Bool = false
    
    let pref = UserDefaults.standard
    
    var interstitial : GADInterstitial!
    var tap: UITapGestureRecognizer = UITapGestureRecognizer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.bannerView.adUnitID = "ca-app-pub-9708689777907361/8592613936"
        self.bannerView.rootViewController = self
        self.bannerView.load(GADRequest())
        
        let alert = UIAlertController(title: "How to use", message: "Enter the score to be added on each row and when you're done it will be added for you!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "CONFIRM", style: UIAlertActionStyle.default, handler:{ (UIAlertAction) -> Void in
            
        }))
        self.present(alert, animated: true, completion: nil)
        
        interstitial = createAndLoadInterstitial()
        
        scrollView.contentSize.height = 1300
        
        
            column1.append(row1col1)
            column1.append(row2col1)
            column1.append(row3col1)
            column1.append(row4col1)
            column1.append(row5col1)
            column1.append(row6col1)
            column1.append(row7col1)
            column1.append(row8col1)
            column1.append(row9col1)
            column1.append(row10col1)
            column1.append(row11col1)
            column1.append(row12col1)
            column1.append(row13col1)
            column1.append(row14col1)
            column1.append(row15col1)
            column1.append(row16col1)
            column1.append(row17col1)
            column1.append(row18col1)
            column1.append(row19col1)
            column1.append(row20col1)
            column1.append(row21col1)
            column1.append(row22col1)
            column1.append(row23col1)
            column1.append(row24col1)
            column1.append(row25col1)
            column1.append(row26col1)
            column1.append(row27col1)
            column1.append(row28col1)
            column1.append(row29col1)
            column1.append(row30col1)
        
        
            column2.append(row1col2)
            column2.append(row2col2)
            column2.append(row3col2)
            column2.append(row4col2)
            column2.append(row5col2)
            column2.append(row6col2)
            column2.append(row7col2)
            column2.append(row8col2)
            column2.append(row9col2)
            column2.append(row10col2)
            column2.append(row11col2)
            column2.append(row12col2)
            column2.append(row13col2)
            column2.append(row14col2)
            column2.append(row15col2)
            column2.append(row16col2)
            column2.append(row17col2)
            column2.append(row18col2)
            column2.append(row19col2)
            column2.append(row20col2)
            column2.append(row21col2)
            column2.append(row22col2)
            column2.append(row23col2)
            column2.append(row24col2)
            column2.append(row25col2)
            column2.append(row26col2)
            column2.append(row27col2)
            column2.append(row28col2)
            column2.append(row29col2)
            column2.append(row30col2)
        
        setPreviousValues()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        addTargetsForTextFields()
 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var i = 0;
        for view in self.scrollView.subviews {
            
            if let textField = view as? UITextField {
                self.pref.setValue(textField.text, forKey: "\(i)")
            }
            
            i += 1;
        }
        
        self.pref.setValue(team1.text, forKey: "team1")
        self.pref.setValue(team2.text, forKey: "team2")
        
        pref.synchronize()
    }
    
    func setPreviousValues() {
        var i = 0;
        
        team1.text = self.pref.string(forKey: "team1")
        team2.text = self.pref.string(forKey: "team2")
        for view in self.scrollView.subviews {
            
            if let textField = view as? UITextField {
                textField.text = self.pref.string(forKey: "\(i)")
            }
            i += 1;
        }
    }
    
    // adds event notifications for all textFields to check for when value changes and editing is done
    func addTargetsForTextFields () {
        var i = 0
        while (i < column1.count ) {
            column1[i]?.tag = i
            column1[i]?.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
            column1[i]?.addTarget(self, action: #selector(ViewController.column1TextFieldTextDidEndEditingNotification(_:)), for: UIControlEvents.editingDidEnd)
            i += 1
        }
        i = 0
        while (i < column2.count) {
            column2[i].tag = i
            column2[i].addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
            column2[i].addTarget(self, action: #selector(ViewController.column2TextFieldTextDidEndEditingNotification(_:)), for: UIControlEvents.editingDidEnd)
            i += 1
        }
        
    }
    
    // checks to see if textField was edited or not, if value isn't changed addition wont occur
    func textFieldDidChange(_ textField: UITextField){
        valueDidChange = true
    }
    
    //adds column 1 scores for indicated rows
    func column1TextFieldTextDidEndEditingNotification(_ textField: UITextField){
        
        tag = textField.tag
        
        // checks that this isnt the first row , neither this textField or previous one is black and that the value of current textField has been changed
        if ((textField.tag != 0) && ((textField.text?.isEmpty)! == false) && (valueDidChange) && ((column1[tag - 1]?.text?.isEmpty)! == false)){
            
            textField.text = String(Int((column1[tag]?.text!)!)! + Int((column1[tag - 1]?.text!)!)!)
            valueDidChange = false
        }
    }
    
    //adds column 2 scores for indicated rows
    func column2TextFieldTextDidEndEditingNotification(_ textField: UITextField){
        
        tag = textField.tag
        
                // checks that this isnt the first row , neither this textField or previous one is black and that the value of current textField has been changed
        if ((textField.tag != 0) && (textField.text?.isEmpty == false) && (valueDidChange) && (column2[tag - 1].text?.isEmpty == false)){
            
            textField.text = String(Int(column2[tag].text!)! + Int(column2[tag - 1].text!)!)
            valueDidChange = false
        }
    }

    // dismisses keyboard on tap
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func clearButton() {
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print(interstitial.debugDescription)
            // accounts for lack of network connectivity/airplane mode
            showClearDialog()
        }
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-9708689777907361/7671681136")
        let request = GADRequest()
        interstitial.delegate = self
        interstitial.load(request)
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        showClearDialog()
    }
    
    func showClearDialog(){
        let alert = UIAlertController(title: "Confirm Clear", message: "Are you sure you want to clear the scores? All data will be erased.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "CONFIRM", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            for view in self.scrollView.subviews {
                
                if let textField = view as? UITextField {
                    textField.text = ""
                }
            }
            self.team1.text = ""
            self.team2.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}








