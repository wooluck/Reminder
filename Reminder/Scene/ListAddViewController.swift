//
//  ListAddViewController.swift
//  Reminder
//
//  Created by pineone on 2022/10/06.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import SnapKit

class ListAddViewController: UIViewController {
    
    private lazy var customNavigationItem = CustomNavigationItem(leftButtonText: "취소", rightButtonText: "완료", navigationTitleText: "새로운 목록")
    
    private lazy var colorImageView = UIImageView().then {
        $0.image = .init(systemName: "list.bullet.circle.fill")
        $0.layer.shadowColor = UIColor.cyan.cgColor
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowRadius = 10
//        $0.layer.shadowOffset = CGSize(width: 10, height: 10)
        $0.layer.shadowPath = nil
    }
    
    private lazy var listTextField = UITextView().then {
        $0.font = .systemFont(ofSize: 22, weight: .bold)
        $0.textAlignment = .center
        $0.backgroundColor = .systemGray4
        $0.textColor = UIColor(red: 80 / 255, green: 152 / 255, blue: 250 / 255, alpha: 1)
        $0.layer.cornerRadius = 12
    }
    
    private lazy var redButton = UIButton().then {
        $0.setTitleColor(.blue, for: .normal)
    }
//    private lazy var colorButtons =
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLayout()
        
    }
}

extension ListAddViewController {
    private func setupLayout() {
        view.addSubviews([customNavigationItem, colorImageView, listTextField])
        customNavigationItem.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
//            $0.trailing.equalToSuperview()
//            $0.width.equalTo(self.view.frame.size.width)
        }
        colorImageView.snp.makeConstraints {
            $0.top.equalTo(customNavigationItem.snp.bottom).inset(-70)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(120)
        }
        listTextField.snp.makeConstraints {
            $0.top.equalTo(colorImageView.snp.bottom).inset(-30)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
    }

}


/*
 <메모>
 modal형식의 화면전환일 때는 navigationItem이 나오지 않는다.
 */
