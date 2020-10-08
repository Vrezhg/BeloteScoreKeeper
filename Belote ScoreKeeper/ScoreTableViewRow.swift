//
//  ScoreTableViewRow.swift
//  Belote ScoreKeeper
//
//  Created by Vrezh Gulyan on 10/4/20.
//  Copyright © 2020 Revenge Apps Inc. All rights reserved.
//

import UIKit
import SnapKit

class ScoreTableViewRow: UITableViewCell {
    
    lazy var scoreStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillProportionally
        
        return stackview
    }()
    
    lazy var firstColumn: UITextField = {
        let textField = ScoreTextField()
        textField.placeholder = "Add"
        return textField
    }()
    
    lazy var secondColumn: UITextField = {
        let textField = ScoreTextField()
        textField.placeholder = "Add"
        return textField
    }()
    
    lazy var wagerColumn: UITextField = {
        let textField = ScoreTextField()
        textField.placeholder = "#"
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        scoreStack.addArrangedSubview(firstColumn)
        scoreStack.setCustomSpacing(19, after: firstColumn)
        scoreStack.addArrangedSubview(secondColumn)
        scoreStack.setCustomSpacing(21, after: secondColumn)
        scoreStack.addArrangedSubview(wagerColumn)
        addSubview(scoreStack)
        
        firstColumn.snp.makeConstraints { make in
            make.width.equalTo(85)
            make.height.equalTo(25)
        }
        
        secondColumn.snp.makeConstraints { make in
            make.width.equalTo(85)
            make.height.equalTo(25)
        }
        
        wagerColumn.snp.makeConstraints { make in
            make.width.equalTo(45)
            make.height.equalTo(25)
        }
        
        scoreStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ScoreTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont(name: "Noteworthy-Light", size: 16)
        clearButtonMode = .never
        keyboardType = .numberPad
        textAlignment = .center
        borderStyle = .roundedRect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
