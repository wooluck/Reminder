//
//  NewReminderDetailPriorityCell.swift
//  Reminder
//
//  Created by pineone on 2022/10/14.
//

import UIKit
import SnapKit

class NewReminderDetailPriorityCell: UITableViewCell {
    static let identifier = "NewReminderDetailPriorityCell"
    
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

extension NewReminderDetailPriorityCell {
    private func setupLayout() {
        addSubviews([leftImageInCell, rightTextInCell])
        leftImageInCell.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        rightTextInCell.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
