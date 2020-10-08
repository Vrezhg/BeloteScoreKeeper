//
//  MainViewController.swift
//  Belote ScoreKeeper
//
//  Created by Vrezh Gulyan on 2/14/16.
//  Copyright © 2016 Revenge Apps Inc. All rights reserved.
//

import GoogleMobileAds
import SnapKit
import UIKit

final class MainViewController: UIViewController , GADInterstitialDelegate {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Belote ScoreKeeper"
        label.textColor = .init(white: 1, alpha: 0.8)
        label.font = UIFont(name: "Noteworthy-Bold", size: 17)
        
        return label
    }()
    
    lazy var noAdsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "noads"),
                        for: .normal)
        button.addTarget(self,
                         action: #selector(noAdsButtonsPressed),
                         for: .touchUpInside)
        return button
    }()
    
    lazy var headerStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        
        return stackview
    }()
    
    lazy var teamOneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Team 1"
        textField.text = pref.string(forKey: "team1")
        textField.textAlignment = .center
        textField.backgroundColor = .init(white: 1, alpha: 0.50)
        textField.font = UIFont(name: "Noteworthy-Bold", size: 16)
        textField.clearButtonMode = .never
        textField.borderStyle = .roundedRect
        textField.addTarget(self,
                            action: #selector(teamOneTextDidChange(_:)),
                            for: .editingDidEnd)
        return textField
    }()
    
    lazy var teamTwoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Team 2"
        textField.text = pref.string(forKey: "team2")
        textField.textAlignment = .center
        textField.backgroundColor = .init(white: 1, alpha: 0.50)
        textField.font = UIFont(name: "Noteworthy-Bold", size: 16)
        textField.clearButtonMode = .never
        textField.borderStyle = .roundedRect
        textField.addTarget(self,
                            action: #selector(teamTwoTextDidChange(_:)),
                            for: .editingDidEnd)
        return textField
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.init(white: 1, alpha: 0.8),
                             for: .normal)
        button.addTarget(self,
                         action: #selector(clearButtonPressed),
                         for: .touchUpInside)
        return button
    }()
    
    lazy var scoreTable: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ScoreTableViewRow.self, forCellReuseIdentifier: "scoreCell")
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        
        return tableView
    }()
    
    lazy var bannerView: GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-9708689777907361/8592613936"
        banner.rootViewController = self
        banner.load(GADRequest())
        
        return banner
    }()
    
    var tag : Int = 0 // tag for textFields
    var valueDidChange : Bool = false
    
    let pref = UserDefaults.standard
    
    var interstitial : GADInterstitial!
    var tap: UITapGestureRecognizer = UITapGestureRecognizer()
    
    var clearPressed = false
    
    lazy var adTimer: Timer = {
        let timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(presentInterstitialAd), userInfo: nil, repeats: true)
        return timer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayDismissableAlert(title: "How to use",
                                message: "Enter the score to be added on each row and when you're done it will be added for you!")
        interstitial = createAndLoadInterstitial()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setupSubviews()
        setupConstraints()
        Timer.scheduledTimer(timeInterval: 90, target: self, selector: #selector(presentInterstitialAd), userInfo: nil, repeats: true)
    }
    
    private func setupSubviews() {
        view.addSubview(titleLabel)
//        view.addSubview(noAdsButton)
        view.addSubview(headerStack)
        view.addSubview(scoreTable)
        view.addSubview(bannerView)
        
        headerStack.addArrangedSubview(teamOneTextField)
        headerStack.addArrangedSubview(teamTwoTextField)
        headerStack.addArrangedSubview(clearButton)
        headerStack.setCustomSpacing(19, after: teamOneTextField)
        headerStack.setCustomSpacing(16, after: teamTwoTextField)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
        }
        
//        noAdsButton.snp.makeConstraints { make in
//            make.width.height.equalTo(45)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.trailing.equalToSuperview().offset(-20)
//        }
        
        teamOneTextField.snp.makeConstraints { make in
            make.width.equalTo(85)
        }
        
        teamTwoTextField.snp.makeConstraints { make in
            make.width.equalTo(85)
        }
        
        headerStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(85)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        bannerView.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        scoreTable.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom).offset(25)
            make.bottom.equalTo(bannerView.snp.top).offset(-25)
            make.leading.trailing.equalToSuperview()
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
        if clearPressed {
            showClearDialog()
            clearPressed = false
        }
    }

    func showClearDialog() {
        let alert = UIAlertController(title: "Confirm Clear",
                                      message: "Are you sure you want to clear the scores? All data will be erased.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL",
                                      style: .default,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: "CONFIRM",
                                      style: .default,
                                      handler: { (UIAlertAction) -> Void in
            self.teamOneTextField.text = ""
            self.teamTwoTextField.text = ""
        
            self.pref.removeObject(forKey: "team1")
            self.pref.removeObject(forKey: "team2")
            var i = 0
            while i < 30 {
                self.pref.removeObject(forKey: "row\(i)column1")
                self.pref.removeObject(forKey: "row\(i)column2")
                self.pref.removeObject(forKey: "row\(i)")
                i += 1
            }
            self.scoreTable.reloadData()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // checks to see if textField was edited or not, if value isn't changed addition wont occur
    @objc func textFieldDidChange(_ textField: UITextField) {
        valueDidChange = true
    }
    
    @objc func teamOneTextDidChange(_ textField: UITextField) {
        pref.setValue(textField.text, forKey: "team1")
    }
    
    @objc func teamTwoTextDidChange(_ textField: UITextField) {
        pref.setValue(textField.text, forKey: "team2")
    }
    
    //adds column 1 scores for indicated rows
    @objc func column1TextFieldTextDidEndEditingNotification(_ textField: UITextField) {
        guard textField.tag != 0,
            textField.text?.isEmpty == false else { return }
        tag = textField.tag
        // checks that this isnt the first row , neither this textField or previous one is blank and that the value of current textField has been changed
        if let previousRow = scoreTable.cellForRow(at: IndexPath(row: tag - 1, section: 0)) as? ScoreTableViewRow {
            let previousRowFirstColumn = previousRow.firstColumn
            if valueDidChange {
                if previousRowFirstColumn.text?.isEmpty == false {
                    if let currentColumnText = textField.text,
                        let currentColumnScore = Int(currentColumnText),
                        let previousColumnText = previousRowFirstColumn.text,
                        let previousColumnScore = Int(previousColumnText) {
                        let newScore = String(previousColumnScore + currentColumnScore)
                        textField.text = newScore
                        
                        pref.set(newScore, forKey: "row\(tag)column1")
                        valueDidChange = false
                    }
                } else {
                    pref.set(textField.text, forKey: "row\(tag)column1")
                }
            }
        }
    }
    
    //adds column 2 scores for indicated rows
    @objc func column2TextFieldTextDidEndEditingNotification(_ textField: UITextField) {
        guard textField.tag != 0,
            textField.text?.isEmpty == false else { return }
        tag = textField.tag
        if let previousRow = scoreTable.cellForRow(at: IndexPath(row: tag - 1, section: 0)) as? ScoreTableViewRow {
            let previousRowSecondColumn = previousRow.secondColumn
            if valueDidChange {
                if previousRowSecondColumn.text?.isEmpty == false {
                    if let currentColumnText = textField.text,
                        let currentColumnScore = Int(currentColumnText),
                        let previousColumnText = previousRowSecondColumn.text,
                        let previousColumnScore = Int(previousColumnText) {
                        let newScore = String(previousColumnScore + currentColumnScore)
                        textField.text = newScore
                        
                        pref.set(newScore, forKey: "row\(tag)column2")
                        valueDidChange = false
                    }
                } else {
                    pref.set(textField.text, forKey: "row\(tag)column2")
                }
            }
        }
    }
    
    @objc func wagerTextFieldTextDidEndEditingNotification(_ textField: UITextField) {
        if let scoreColumn = scoreTable.cellForRow(at: IndexPath(row: textField.tag, section: 0)) as? ScoreTableViewRow {
            pref.set(scoreColumn.wagerColumn.text, forKey: "row\(textField.tag)")
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func presentInterstitialAd() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
    }
    
    @objc func clearButtonPressed() {
        clearPressed = true
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            showClearDialog()
        }
    }
    
    @objc func noAdsButtonsPressed() {
        let upsellViewContoller = UpsellViewController()
        upsellViewContoller.modalPresentationStyle = .overFullScreen
        present(upsellViewContoller,
                animated: true,
                completion: nil)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        35
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell") as! ScoreTableViewRow
        cell.firstColumn.addTarget(self,
                                   action: #selector(textFieldDidChange(_:)),
                                   for: .editingChanged)
        cell.firstColumn.addTarget(self,
                                   action: #selector(column1TextFieldTextDidEndEditingNotification(_:)),
                                   for: .editingDidEnd)
        cell.firstColumn.tag = indexPath.row
        cell.firstColumn.text = pref.string(forKey: "row\(indexPath.row)column1")
        
        cell.secondColumn.addTarget(self,
                                    action: #selector(textFieldDidChange(_:)),
                                    for: .editingChanged)
        cell.secondColumn.addTarget(self,
                                    action: #selector(column2TextFieldTextDidEndEditingNotification(_:)),
                                    for: .editingDidEnd)
        cell.secondColumn.tag = indexPath.row
        cell.secondColumn.text = pref.string(forKey: "row\(indexPath.row)column2")
        
        cell.wagerColumn.tag = indexPath.row
        cell.wagerColumn.addTarget(self,
                                   action: #selector(wagerTextFieldTextDidEndEditingNotification(_:)),
                                   for: .editingDidEnd)
        cell.wagerColumn.text = pref.string(forKey: "row\(indexPath.row)")
        
        return cell
    }
}

extension UIViewController {
    public func displayDismissableAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert,
                animated: true,
                completion: nil)
    }
}
