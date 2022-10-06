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
        $0.image = UIImage(systemName: "list.star")
    }
    
    private lazy var textInCell = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private lazy var numberInCell = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private lazy var arrowInCell = UIImageView().then {
        $0.image = UIImage(systemName: "arrow.right")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTableViewCell {
    private func setupLayout() {
        addSubviews([imageInCell, textInCell, numberInCell, arrowInCell])
        imageInCell.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        textInCell.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(imageInCell.snp.trailing)
        }
        numberInCell.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalTo(arrowInCell.snp.leading)
        }
        arrowInCell.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(30)
        }
    }
    
    func configureView() {
        
    }
}
