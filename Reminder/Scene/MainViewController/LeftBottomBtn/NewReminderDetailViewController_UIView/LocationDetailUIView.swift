//
//  LocationDetailUIView.swift
//  Reminder
//
//  Created by pineone on 2022/10/14.
//

import Foundation
import UIKit

class LocationDetailUIView: UIView {
    
    private lazy var nowImage = UIImageView().then {
        $0.image = UIImage(systemName: "location.circle.fill")
        $0.tintColor = .gray
    }
    private lazy var getInImage = UIImageView().then {
        $0.image = UIImage(systemName: "car.circle.fill")
    }
    private lazy var getOutImage = UIImageView().then {
        $0.image = UIImage(systemName: "car.circle.fill")
    }
    private lazy var etcImage = UIImageView().then {
        $0.image = UIImage(systemName: "ellipsis.circle.fill")
        $0.tintColor = .gray
    }
    
    private lazy var nowButton = UIButton().then {
        $0.setTitle("현재", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    private lazy var getInButton = UIButton().then {
        $0.setTitle("차에 탈 때", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    private lazy var getOutButton = UIButton().then {
        $0.setTitle("차에서 내릴 때", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    private lazy var etcButton = UIButton().then {
        $0.setTitle("사용자화", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    
    private lazy var iconStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    
    private lazy var labelStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalCentering
//        $0.spacing = 5
//        $0.backgroundColor = .green
    }
    
    private lazy var underLine = UIView().then {
        $0.backgroundColor = .systemGray3
    }
    
    private lazy var locationLabelView = LocationDetailLabelUIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
//        backgroundColor = .purple
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LocationDetailUIView {
    private func setupLayout() {
        [nowImage, getInImage, getOutImage, etcImage].forEach {
            self.iconStackView.addArrangedSubview($0)
        }
        
        [nowButton, getInButton, getOutButton, etcButton].forEach {
            self.labelStackView.addArrangedSubview($0)
        }
//
//        [iconStackView, labelStackView].forEach {
//            self.totalStackView.addArrangedSubview($0)
//        }
        
        addSubviews([iconStackView, labelStackView, underLine, locationLabelView])
        iconStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }

        labelStackView.snp.makeConstraints {
            $0.top.equalTo(iconStackView.snp.bottom)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(20)
        }
        underLine.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom)
            $0.leading.equalToSuperview().inset(55)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        locationLabelView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }
    }
}
