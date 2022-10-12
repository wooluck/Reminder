//
//  CustomNavigationItem.swift
//  Reminder
//
//  Created by pineone on 2022/10/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class CustomNavigationItem: UIView {
    var disposeBag = DisposeBag()
    
    private var leftButtonText: String
    private var rightButtonText: String
    private var navigationTitleText: String
    
    lazy var leftButton = UIButton().then {
        $0.setTitle(leftButtonText, for: .normal)
        $0.setTitleColor(UIColor(red: 80 / 255, green: 152 / 255, blue: 250 / 255, alpha: 1), for: .normal)
    }
    
    lazy var rightButton = UIButton().then {
        $0.setTitle(rightButtonText, for: .normal)
        $0.isEnabled = false
    }

    private lazy var navigationTitle = UILabel().then {
        $0.text = navigationTitleText
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    init(leftButtonText: String, rightButtonText: String, navigationTitleText: String) {
        self.leftButtonText = leftButtonText
        self.rightButtonText = rightButtonText
        self.navigationTitleText = navigationTitleText
        super.init(frame: .zero)
        setupLayout()
        bindView()
//        backgroundColor = .green
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomNavigationItem {
    private func bindView() {
//        leftButton.rx.tap
//            .subscribe(onNext: {
//                print("눌림?")
//            }).disposed(by: disposeBag)
    }
    
    private func setupLayout() {
        addSubviews([leftButton, navigationTitle, rightButton])
        leftButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        navigationTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.centerX.equalToSuperview()
            
        }
        rightButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

    }
}
