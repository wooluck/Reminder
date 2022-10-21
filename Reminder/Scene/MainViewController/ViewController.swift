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

struct List {
    let title: String
    let number: String
}

let ListDummy: [List] = [List(title: "미리 알림", number: "0")]

class ViewController: UIViewController {
    var disposeBag = DisposeBag()

    private let tableData = Observable.of(ListDummy.map { $0 })
    
    private lazy var searchBar = CustomSearchBar()
    
    private lazy var contentsScrollView = UIScrollView().then {
        $0.backgroundColor = UIColor.systemGray6
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var buttonsView = UIView().then {
        $0.backgroundColor = UIColor.systemGray6
    }
    
    private lazy var todayButtonInScrollView = CustomButton(image: "clock.badge.checkmark", text: "오늘", number: "0", imageColor: "")
    
    private lazy var laterButtonInScrollView = CustomButton(image: "calendar.circle.fill", text: "예정", number: "0", imageColor: "")
    
    private lazy var AllButtonInScrollView = CustomButton(image: "folder.circle.fill", text: "전체", number: "0", imageColor: "")
    
    private lazy var myListTitle = UILabel().then {
        $0.text = "나의 목록"
        $0.font = UIFont.systemFont(ofSize: 23, weight: .bold)
    }
    
    private lazy var tableView = UITableView().then {
        $0.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        $0.layer.cornerRadius = 10
        $0.estimatedRowHeight = 50
        $0.rowHeight = UITableView.automaticDimension
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
    
    //MARK: - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6
        bindTableView()
        bindView()
        navigationSetup()
        setupLayout()
    }
}

//MARK: - extension
extension ViewController {
    private func bindTableView() {
        tableData.bind(to: tableView.rx.items) { tableView, row, element in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
            cell.textInCell.text = element.title
            cell.numberInCell.text = element.number
            cell.accessoryType = .disclosureIndicator
            return cell
        }.disposed(by: disposeBag)
    }
    
    private func bindView() {
        self.bottomRightButton.rx.tap
            .subscribe(onNext: {
                self.present(ListAddViewController(), animated: true)
            }).disposed(by: disposeBag)
        
        self.bottomLeftButton.rx.tap
            .subscribe(onNext: {
//                self.present(NewReminderAddViewController(), animated: true)
                self.navigationController?.pushViewController(NewReminderAddViewController(), animated: true)
            }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(List.self)
            .subscribe(onNext: { [weak self] member in
                guard let `self` = self else { return }
                self.navigationController?.pushViewController(CustomDetailViewController(), animated: true)
            }).disposed(by: disposeBag)
        
//        tableView.rx.itemSelected
//            .subscribe { [weak self] indexPath in
//                //셀 선택 상태 제거
//                self?.tableView.deselectRow(at: indexPath, animated: true)
//            }.disposed(by: disposeBag)
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
        
        contentsScrollView.addSubviews([buttonsView, myListTitle, tableView])
        buttonsView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(155)
        }
        myListTitle.snp.makeConstraints {
            $0.top.equalTo(buttonsView.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().offset(15)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(myListTitle.snp.bottom).inset(-10)
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

