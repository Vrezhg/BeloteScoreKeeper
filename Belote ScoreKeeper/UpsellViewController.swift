//
//  noadds.swift
//  Belote ScoreKeeper
//
//  Created by Vrezh Gulyan on 9/15/17.
//  Copyright © 2017 Revenge Apps Inc. All rights reserved.
//

import Foundation
import Purchases
import SnapKit
import UIKit

final class UpsellViewController: UIViewController {
    
    lazy var blurredEffectView: UIView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        
        return blurredEffectView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: 0.85,
                                     green:0.85,
                                     blue:0.85,
                                     alpha:1.0)
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeImage"),
                        for: .normal)
        button.addTarget(self,
                         action: #selector(dismissButtonPressed),
                         for: .touchUpInside)
        return button
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Unlock the ad-free version of this app for only $1.99"
        label.font = UIFont(name: "Noteworthy-Bold", size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var unlockNoAdsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Unlock no Ads",
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 14)
        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        
        return button
    }()
    
    lazy var restorePurchasesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Restore Purchase",
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 14)
        return button
    }()
    
    var nonConsumablePurchaseMade = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check your In-App Purchases
        print("NON CONSUMABLE PURCHASE MADE: \(nonConsumablePurchaseMade)")
                
        // messageLabel.text = nonConsumablePurchaseMade ? "Ad-free unlocked!" : "Ad-free version LOCKED!"
        
        // Fetch IAP Products available
        fetchAvailableProducts()
        view.backgroundColor = .clear
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        
        view.addSubview(blurredEffectView)
        view.addSubview(containerView)
        containerView.addSubview(closeButton)
        containerView.addSubview(priceLabel)
        containerView.addSubview(unlockNoAdsButton)
        containerView.addSubview(restorePurchasesButton)
    }
    
    func setupConstraints() {
        blurredEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(containerView.snp.width).offset(-50)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.width.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        unlockNoAdsButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(restorePurchasesButton)
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.height.equalTo(35)
        }
        
        restorePurchasesButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.bottom.equalTo(containerView.snp.bottom).offset(-10)
            make.height.equalTo(35)
        }
    }
    
    func fetchAvailableProducts() {
        Purchases.shared.products(["no_ads"]) { products in
            print("Current products: \(products)")
        }
        Purchases.shared.offerings { (offerings, error) in
            if let offerings = offerings {
                print("Current offerings: \(offerings.all)")
          }
        }
    }
    
    // MARK: - REQUEST IAP PRODUCTS
    func productsRequest () {
        priceLabel.text = "Unlock the ad-free version of this app for only $1.99"
    }
    
    @objc func dismissButtonPressed() {
       dismiss(animated: true, completion: nil)
    }
    
    @objc func unlockButtonPressed() {
        
    }
    
    @objc func restorePurchasesButtonPressed() {
        
    }
    
    // MARK: - MAKE PURCHASE OF A PRODUCT
    func canMakePurchases() -> Bool {
        return false
    }
    
    func purchaseMyProduct() {
        if self.canMakePurchases() {
            
            // IAP Purchases dsabled on the Device
        } else {
//            displayDismissableAlert(title: "Failure",
//                                    message: "Purchases are disabled on your device!")
        }
    }
   
    
    
    func paymentQueueRestoreCompletedTransactionsFinished() {
        nonConsumablePurchaseMade = true
        UserDefaults.standard.set(nonConsumablePurchaseMade,
                                  forKey: "nonConsumablePurchaseMade")
//        displayDismissableAlert(title: "Success",
//                                message: "You've successfully restored your purchase!")
    }
}
