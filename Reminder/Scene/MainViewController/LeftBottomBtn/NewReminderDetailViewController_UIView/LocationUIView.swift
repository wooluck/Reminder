//
//  LocationUIView.swift
//  Reminder
//
//  Created by pineone on 2022/10/14.
//

import Foundation
import UIKit

class LocationUIView: UIView {
    
    private lazy var image = UIImageView().then {
        $0.image = UIImage(systemName: "location.circle.fill")
    }
    
    private lazy var text = UILabel().then {
        $0.text = "위치"
    }
    
    private lazy var switchBtn = UISwitch()
//        .then {
//        $0.addTarget(self, action: #selector(changeIsOn(sender:)), for: .valueChanged)
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LocationUIView {
    private func setupLayout() {
        addSubviews([image, text, switchBtn])
        image.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(35)
        }
        text.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalTo(image.snp.trailing).offset(10)
        }
        switchBtn.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
        
    }
}
