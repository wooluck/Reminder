//
//  DayTextUIView.swift
//  Reminder
//
//  Created by pineone on 2022/10/13.
//

import Foundation
import UIKit

class DayTextUIView: UIView {
    
    var detailVC = NewReminderDetailViewController()
    
    private lazy var image = UIImageView().then {
        $0.image = UIImage(systemName: "calendar.circle.fill")
        $0.tintColor = .red
    }
    private lazy var text = UILabel().then {
        $0.text = "날짜"
    }
    private lazy var dayText = UILabel().then {
        $0.text = "오늘"
        $0.textColor = .blue
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    var switchBtn = UISwitch().then {
        $0.addTarget(self, action: #selector(changeIsOn(sender:)), for: .valueChanged)
    }
    
    private lazy var underLine = UIView().then {
        $0.backgroundColor = .systemGray3
    }
    
    // MARK: - init()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - @objc
    @objc func changeIsOn(sender: UISwitch) {
        detailVC.calendarIsOn = switchBtn.isOn
        print("switchBtn.isOn : \(detailVC.calendarIsOn)")
    }
}

    // MARK: - extensions
extension DayTextUIView {
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
//            $0.top.equalToSuperview().inset(10)
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
