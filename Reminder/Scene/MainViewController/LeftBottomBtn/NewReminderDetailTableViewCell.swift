//
//  NewReminderDetailTableViewCell.swift
//  Reminder
//
//  Created by pineone on 2022/10/12.
//

import Foundation
import UIKit

// 이미지 - 텍스트 - 스위치버튼
class NewReminderDetailTableViewCell: UITableViewCell {
    static let identifier = "NewReminderDetailTableViewCell"
    
    lazy var leftImageInCell = UIImageView()
    
    lazy var centerTextInCell = UILabel()
    
    lazy var centerDayTextInCell = UILabel()
    
    lazy var rightSwitchInCell = UISwitch()
    
    // MARK: - init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - extension
extension NewReminderDetailTableViewCell {
    private func setupLayout() {
        addSubviews([leftImageInCell, centerTextInCell, centerDayTextInCell, rightSwitchInCell])
        leftImageInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().inset(7)
            $0.width.height.equalTo(30)
        }
        centerTextInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(1)
            $0.leading.equalTo(leftImageInCell.snp.trailing).offset(10)
        }
        centerDayTextInCell.snp.makeConstraints {
            $0.top.equalTo(centerTextInCell.snp.bottom)
            $0.leading.equalTo(leftImageInCell.snp.trailing).offset(10)
        }
        rightSwitchInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(40)
        }
        
    }
}
