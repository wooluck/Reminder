//
//  LocationDetailLabelUIView.swift
//  Reminder
//
//  Created by pineone on 2022/10/14.
//

import Foundation
import UIKit

class LocationDetailLabelUIView: UIView {
    private lazy var locationLabel = UILabel().then {
        $0.text = "도착할 때 : 경기도 용인시 기흥구"
    }
    private lazy var iIconButton = UIButton().then {
//        $0.image = .init(systemName: "info.circle")
        $0.setImage(.init(systemName: "info.circle"), for: .normal)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .white
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LocationDetailLabelUIView {
    private func setupLayout() {
        addSubviews([locationLabel, iIconButton])
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(iIconButton.snp.leading)
        }
        iIconButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(30)
        }

    }
}
