//
//  NewReminderAddListTableViewCell.swift
//  Reminder
//
//  Created by pineone on 2022/10/11.
//

import UIKit
import SnapKit

class NewReminderAddListTableViewCell: UITableViewCell {
    static let identifier = "NewReminderAddListTableViewCell"
    
    lazy var leftTextInCell = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }
    
    lazy var imageInCell = UIImageView().then {
        $0.image = UIImage(systemName: "circle.fill")
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
    // MARK: - extension
extension NewReminderAddListTableViewCell {
    private func setupLayout() {
        addSubviews([leftTextInCell, imageInCell, rightTextInCell])
        leftTextInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        imageInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.trailing.equalTo(rightTextInCell.snp.leading).offset(-5)
            $0.width.height.equalTo(10)
        }
        rightTextInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(40)
        }
    }
}
