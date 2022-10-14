//
//  NewReminderDetailReplyCell.swift
//  Reminder
//
//  Created by pineone on 2022/10/14.
//

import UIKit
import SnapKit

class NewReminderDetailReplyCell: UITableViewCell {
    static let identifier = "NewReminderDetailReplyCell"
    
    lazy var imageInCell = UIImageView().then {
        $0.image = UIImage(systemName: "repeat.circle.fill")
        $0.tintColor = .gray
    }
    
    lazy var leftImageInCell = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }

    lazy var rightTextInCell = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        $0.textColor = .gray
    }
    
    // MARK: - init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewReminderDetailReplyCell {
    private func setupLayout() {
        addSubviews([imageInCell, leftImageInCell, rightTextInCell])
        imageInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(35)
        }
        leftImageInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(imageInCell.snp.trailing).offset(10)
        }
        rightTextInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(40)
        }
    }
}
