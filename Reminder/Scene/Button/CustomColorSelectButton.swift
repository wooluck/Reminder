//
//  CustomColorSelectButton.swift
//  Reminder
//
//  Created by pineone on 2022/10/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class CustomColorSelectButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomColorSelectButton {
    private func setupView() {
//        backgroundColor = .red
        layer.cornerRadius = 20
        layer.borderWidth = 3
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.masksToBounds = true
//        setTitleColor(.red, for: .normal)
    }
    
    private func setupLayout() {
        
    }
}
