//
//  CustomTableViewCell.swift
//  Reminder
//
//  Created by pineone on 2022/10/05.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    private lazy var imageInCell = UIImageView().then {
        $0.image = UIImage(systemName: "list.bullet.circle.fill")
    }
    
    lazy var textInCell = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }
    
    lazy var numberInCell = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
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
extension CustomTableViewCell {
    private func setupLayout() {
        addSubviews([imageInCell, textInCell, numberInCell])
        imageInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().inset(7)
            $0.width.height.equalTo(30)
        }
        textInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(imageInCell.snp.trailing).offset(10)
        }
        numberInCell.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(40)
        }
    }
    
    func configureView() {
        
    }
}
