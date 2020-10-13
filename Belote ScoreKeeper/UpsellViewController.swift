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

protocol UpsellDelegate: AnyObject {
    func statusUpdated()
}

final class UpsellViewController: UIViewController {
    
    weak var delegate: UpsellDelegate?
    
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
        label.text = "Unlock the ad-free version of this app for only \(price)"
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
        button.isEnabled = false
        button.addTarget(self,
                         action: #selector(unlockButtonPressed),
                         for: .touchUpInside)
        return button
    }()
    
    lazy var restorePurchasesButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Restore Purchase",
                        for: .normal)
        button.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 14)
        button.addTarget(self,
                         action: #selector(restorePurchasesButtonPressed),
                         for: .touchUpInside)
        return button
    }()
    
    var nonConsumablePurchaseMade = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseMade")
    
    lazy var price: String = ""
    
    var currentProduct: SKProduct? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } 
        view.backgroundColor = .clear
        fetchProduct()
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
    
    func fetchProduct() {
        Purchases.shared.offerings { [weak self] (offerings, error) in
            if let product = offerings?.current?.availablePackages.first?.product {
                let numberFormatter = NumberFormatter()
                numberFormatter.locale = product.priceLocale
                numberFormatter.numberStyle = .currency
                self?.currentProduct = product
                self?.price = numberFormatter.string(from: product.price) ?? "1.99"
                self?.unlockNoAdsButton.isEnabled = true
            } else {
                self?.priceLabel.text = "There are no in app purchases available currently, please try again later"
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
        if let currentProduct = currentProduct {
            Purchases.shared.purchaseProduct(currentProduct) { [weak self] (transaction, purchaserInfo, error, userCancelled) in
                if userCancelled || error != nil {
                    self?.displayDismissableAlert(title: "Something went wrong", message: error?.localizedDescription)
                } else {
                    if let state = transaction?.transactionState {
                        switch state {
                        case .purchased:
                            self?.delegate?.statusUpdated()
                            self?.dismiss(animated: true, completion: nil)
                        default:
                            self?.displayDismissableAlert(title: "Something went wrong", message: "")
                        }
                    }
                 }
            }
        }
    }
    
    @objc func restorePurchasesButtonPressed() {
        Purchases.shared.restoreTransactions { [weak self] (_, error) in
            if let error = error {
                self?.displayDismissableAlert(title: "Something went wrong", message: error.localizedDescription)
            } else {
                self?.delegate?.statusUpdated()
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
