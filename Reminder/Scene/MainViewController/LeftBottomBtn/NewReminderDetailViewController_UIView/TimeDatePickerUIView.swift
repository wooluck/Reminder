//
//  TimeDatePickerUIView.swift
//  Reminder
//
//  Created by pineone on 2022/10/13.
//

import Foundation
import UIKit

class TimeDatePickerUIView: UIView {
    
    private lazy var datePickerView = UIDatePicker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        pickerSetup()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TimeDatePickerUIView {
    private func pickerSetup() {
//        self.datePickerView.preferredDatePickerStyle = .wheels
        self.datePickerView.datePickerMode = .time
    }
    
    private func setupLayout() {
        addSubviews([datePickerView])
        datePickerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
