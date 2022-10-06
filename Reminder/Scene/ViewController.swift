//
//  ViewController.swift
//  Reminder
//
//  Created by pineone on 2022/10/05.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    let tableDataRelay = BehaviorRelay<[TableList]>(value: [])
    // TableList.init(title: "더미 데이터")
    
    private lazy var searchBar = CustomSearchBar()
    
    private lazy var contentsScrollView = UIScrollView().then {
        $0.backgroundColor = UIColor.systemGray6
        $0.showsVerticalScrollIndicator = false
    }
    private lazy var buttonsView = UIView().then {
        $0.backgroundColor = UIColor.systemGray6
    }
    private lazy var todayButtonInScrollView = CustomButton(image: "clock.badge.checkmark", text: "오늘", number: "0", imageColor: "")
    private lazy var laterButtonInScrollView = CustomButton(image: "calendar.circle", text: "예정", number: "0", imageColor: "")
    private lazy var AllButtonInScrollView = CustomButton(image: "folder.circle.fill", text: "전체", number: "1", imageColor: "")
    private lazy var tableView = UITableView().then {
        //        $0.backgroundColor = UIColor.systemGray6/
        $0.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    private lazy var bottomFixView = UIView().then {
        $0.backgroundColor = UIColor.systemGray6
    }
    private lazy var bottomLeftButton = UIButton().then {
        $0.setTitleColor(UIColor(red: 80 / 255, green: 152 / 255, blue: 250 / 255, alpha: 1), for: .normal)
        $0.setTitle(" 새로운 미리 알림", for: .normal)
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
    }
    private lazy var bottomRightButton = UIButton().then {
        $0.setTitleColor(UIColor(red: 80 / 255, green: 152 / 255, blue: 250 / 255, alpha: 1), for: .normal)
        $0.setTitle("목록 추가", for: .normal)
    }
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6
        navigationSetup()
        setupLayout()
        bindView()
    }
}

//MARK: - extension
extension ViewController {
    private func bindTableView() {
        tableDataRelay.asDriver()
            .drive(tableView.rx.items) { table, row, item in
                guard let cell = table.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier) as? CustomTableViewCell else { return UITableViewCell()}
                return cell
            }
    }
    
    private func bindView() {
        self.bottomRightButton.rx.tap
            .subscribe(onNext: {
                self.present(ListAddViewController(), animated: true)
            }).disposed(by: disposeBag)
        
        self.bottomLeftButton.rx.tap
            .subscribe(onNext: {
                self.present(NewReminderAddViewController(), animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func navigationSetup() {
        let rightBtn = UIBarButtonItem(title: "편집", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    private func setupLayout() {
        view.addSubviews([searchBar, contentsScrollView, bottomFixView])
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        contentsScrollView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).inset(-5)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(bottomFixView.snp.top)
        }
        bottomFixView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(50)
        }
        
        contentsScrollView.addSubviews([buttonsView, tableView])
        buttonsView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(155)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(buttonsView.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomFixView.snp.top)
        }
        
        buttonsView.addSubviews([todayButtonInScrollView, laterButtonInScrollView, AllButtonInScrollView])
        todayButtonInScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(70)
            $0.width.equalTo(self.view.frame.size.width / 2 - 30)
        }
        laterButtonInScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(todayButtonInScrollView.snp.trailing).inset(-20)
            $0.height.equalTo(70)
            $0.width.equalTo(self.view.frame.size.width / 2 - 30)
        }
        AllButtonInScrollView.snp.makeConstraints {
            $0.top.equalTo(todayButtonInScrollView.snp.bottom).inset(-15)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(70)
            $0.width.equalTo(self.view.frame.size.width - 40)
        }
        
        bottomFixView.addSubviews([bottomLeftButton, bottomRightButton])
        bottomLeftButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        bottomRightButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

