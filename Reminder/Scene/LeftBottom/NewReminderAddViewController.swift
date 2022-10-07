//
//  NewReminderAddViewController.swift
//  Reminder
//
//  Created by pineone on 2022/10/06.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import SnapKit

class NewReminderAddViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    private lazy var customNavigationItem = CustomNavigationItem(leftButtonText: "취소", rightButtonText: "추가", navigationTitleText: "새로운 미리 알림").then {
//        if listTextField.text?.count != 0 {
//            $0.rightButton.isEnabled = true
//            $0.rightButton.setTitleColor(UIColor(red: 80 / 255, green: 152 / 255, blue: 250 / 255, alpha: 1), for: .normal)
//        }else {
//            $0.rightButton.isEnabled = false
//            $0.rightButton.setTitleColor(.gray, for: .normal)
//        }
        print("a : \($0.rightButton.isEnabled)")
    }
    
    private lazy var titleText = UITextField().then {
        $0.placeholder = "제목"
        $0.backgroundColor = .white
    }
    
    private lazy var contentText = UITextView().then {
        $0.backgroundColor = .red
    }
    
    private lazy var detailTableView = UITableView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var listTableView = UITableView().then {
        $0.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bindTableView()
    }
}

extension NewReminderAddViewController {
    private func bindTableView() {
        let detail = Observable.of(["세부사항"])
        detail.bind(to: detailTableView.rx.items) { (tableView: UITableView, index: Int, element: String) in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = element
            print("element : \(element)")
            return cell
        }.disposed(by: disposeBag)
        
        let list = Observable.of(["목록"])
        list.bind(to: listTableView.rx.items) { (tableView: UITableView, index: Int, element: String) in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = element
            print("element : \(element)")
            return cell
        }.disposed(by: disposeBag)
    }
    
    private func setupLayout() {
        view.addSubviews([customNavigationItem, titleText, contentText, detailTableView, listTableView])
        customNavigationItem.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        titleText.snp.makeConstraints {
            $0.top.equalTo(customNavigationItem.snp.bottom).inset(-70)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        contentText.snp.makeConstraints {
            $0.top.equalTo(titleText.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }
        detailTableView.snp.makeConstraints {
            $0.top.equalTo(contentText.snp.bottom).inset(-20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        listTableView.snp.makeConstraints {
            $0.top.equalTo(detailTableView.snp.bottom).inset(-20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
}
