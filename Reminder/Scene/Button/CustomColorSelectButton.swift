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
    
    // MARK: - init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - extension
extension CustomColorSelectButton {
    private func setupView() {
        layer.cornerRadius = 20
        layer.borderWidth = 3
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.masksToBounds = true
    }
    
    private func setupLayout() {
        
    }
}
