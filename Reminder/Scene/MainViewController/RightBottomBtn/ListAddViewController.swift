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

enum ColorType {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
}

class ListAddViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private var colorButtonSelect = BehaviorRelay<ColorType>(value: .red)
    private var colorButton = BehaviorRelay<Bool>(value: true)
    
    private lazy var customNavigationItem = CustomNavigationItem(leftButtonText: "취소", rightButtonText: "완료", navigationTitleText: "새로운 목록").then {
        if listTextField.text?.count != 0 {
            $0.rightButton.isEnabled = true
            $0.rightButton.setTitleColor(UIColor(red: 80 / 255, green: 152 / 255, blue: 250 / 255, alpha: 1), for: .normal)
        }else {
            $0.rightButton.isEnabled = false
            $0.rightButton.setTitleColor(.gray, for: .normal)
        }
        print("a : \($0.rightButton.isEnabled)")
    }
    
    private lazy var colorImageView = UIImageView().then {
        $0.image = .init(systemName: "list.bullet.circle.fill")
        $0.tintColor = .red
        $0.layer.shadowColor = UIColor.red.cgColor
        $0.layer.shadowOpacity = 0.4
        $0.layer.shadowRadius = 10
    }
    
    private lazy var listTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 22, weight: .bold)
        $0.textAlignment = .center
        $0.backgroundColor = .systemGray4
        $0.textColor = .red
        $0.layer.cornerRadius = 12
        $0.clearButtonMode = .whileEditing
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [redButton, orangeButton, yellowButton, greenButton, blueButton, purpleButton]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 20
        $0.alignment = .fill
    }
    
    private lazy var redButton = CustomColorSelectButton().then {
        $0.backgroundColor = .red
        //        $0.configuration?.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    private lazy var orangeButton = CustomColorSelectButton().then {
        $0.backgroundColor = .orange
    }
    
    private lazy var yellowButton = CustomColorSelectButton().then {
        $0.backgroundColor = .yellow
    }
    
    private lazy var greenButton = CustomColorSelectButton().then {
        $0.backgroundColor = .green
    }
    
    private lazy var blueButton = CustomColorSelectButton().then {
        $0.backgroundColor = .blue
    }
    
    private lazy var purpleButton = CustomColorSelectButton().then {
        $0.backgroundColor = .purple
    }
    // MARK: - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        self.listTextField.becomeFirstResponder()
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindView()
        setupLayout()
    }
}

    // MARK: - extension
extension ListAddViewController {
    private func bindView() {
        redButton.rx.tap
            .subscribe(onNext: {
                self.colorImageView.tintColor = .red
                self.colorImageView.layer.shadowColor = UIColor.red.cgColor
                self.listTextField.textColor = .red
            }).disposed(by: disposeBag)
        
        orangeButton.rx.tap
            .subscribe(onNext: {
                self.colorImageView.tintColor = .orange
                self.colorImageView.layer.shadowColor = UIColor.orange.cgColor
                self.listTextField.textColor = .orange
            }).disposed(by: disposeBag)
        
        yellowButton.rx.tap
            .subscribe(onNext: {
                self.colorImageView.tintColor = .yellow
                self.colorImageView.layer.shadowColor = UIColor.yellow.cgColor
                self.listTextField.textColor = .yellow
            }).disposed(by: disposeBag)
        
        greenButton.rx.tap
            .subscribe(onNext: {
                self.colorImageView.tintColor = .green
                self.colorImageView.layer.shadowColor = UIColor.green.cgColor
                self.listTextField.textColor = .green
            }).disposed(by: disposeBag)
        
        blueButton.rx.tap
            .subscribe(onNext: {
                self.colorImageView.tintColor = .blue
                self.colorImageView.layer.shadowColor = UIColor.blue.cgColor
                self.listTextField.textColor = .blue
            }).disposed(by: disposeBag)
        
        purpleButton.rx.tap
            .subscribe(onNext: {
                self.colorImageView.tintColor = .purple
                self.colorImageView.layer.shadowColor = UIColor.purple.cgColor
                self.listTextField.textColor = .purple
            }).disposed(by: disposeBag)
        
        customNavigationItem.leftButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
    }
    
    private func setupLayout() {
        view.addSubviews([customNavigationItem, colorImageView, listTextField, stackView])
        customNavigationItem.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(35)
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
            $0.height.equalTo(45)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(listTextField.snp.bottom).inset(-45)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.listTextField.resignFirstResponder()
    }
}


/*
 <메모>
 modal형식의 화면전환일 때는 navigationItem이 나오지 않는다.
 
 UIStackView는 인스턴스 만들때부터 UIView들을 넣어줘야한다.
 */
