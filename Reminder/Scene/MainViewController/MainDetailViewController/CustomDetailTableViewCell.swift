//
//  CustomDetailTableViewCell.swift
//  Reminder
//
//  Created by pineone on 2022/10/07.
//

import UIKit
import SnapKit

class CustomDetailTableViewCell: UITableViewCell {
    static let identifier = "CustomDetailTableViewCell"
    
    private lazy var imageInCell = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
    }
    
    lazy var detailTextInCell = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
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
extension CustomDetailTableViewCell {
    private func setupLayout() {
        addSubviews([imageInCell, detailTextInCell])
        imageInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().inset(7)
            $0.width.height.equalTo(30)
        }
        detailTextInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(imageInCell.snp.trailing).offset(10)
        }
    }
}
