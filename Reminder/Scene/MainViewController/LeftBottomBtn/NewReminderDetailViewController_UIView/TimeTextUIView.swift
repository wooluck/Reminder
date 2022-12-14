//
//  TimeTextUIView.swift
//  Reminder
//
//  Created by pineone on 2022/10/13.
//

import Foundation
import UIKit

class TimeTextUIView: UIView {
    
//    var detailVC = NewReminderDetailViewController()
    var completion: ((Bool) -> Void)?
    
    private lazy var image = UIImageView().then {
        $0.image = UIImage(systemName: "clock.fill")
    }
    
    private lazy var text = UILabel().then {
        $0.text = "시간"
    }
    
    private lazy var dayText = UILabel().then {
        $0.text = "14:00"
        $0.textColor = .blue
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    private lazy var switchBtn = UISwitch().then {
        $0.addTarget(self, action: #selector(changeIsOn), for: .valueChanged)
    }
    
    private lazy var underLine = UIView().then {
        $0.backgroundColor = .systemGray3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - @objc
    @objc func changeIsOn() {
        completion?(self.switchBtn.isOn)
    }
}

extension TimeTextUIView {
    private func setupLayout() {
        addSubviews([image, text, dayText, switchBtn, underLine])
        image.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(35)
        }
        text.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(image.snp.trailing).offset(10)
        }
        dayText.snp.makeConstraints {
            $0.top.equalTo(text.snp.bottom).offset(3)
            $0.leading.equalTo(image.snp.trailing).offset(10)
        }
        switchBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
        underLine.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(55)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
