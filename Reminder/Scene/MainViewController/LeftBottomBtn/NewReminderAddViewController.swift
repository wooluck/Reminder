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

struct NewReminderAddList {
    var leftText: String
//    var centerImage: UIImageView
    var rightText: String?
}

let NewReminderAddDummy: [NewReminderAddList] = [NewReminderAddList(leftText: "목록", rightText: "미리 알림")]
let NewReminderDetailDummy: [NewReminderAddList] = [NewReminderAddList(leftText: "세부사항")]

class NewReminderAddViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    private let tableData = Observable.of(NewReminderAddDummy.map { $0 })
    private let tableDtailData = Observable.of(NewReminderDetailDummy.map { $0 })
    
    // 텍스트필드 입력시 
    let inputTitle = PublishRelay<String>()
    let inputDescription = PublishRelay<String>()
    let inputTrigger = PublishRelay<ActionType>()
    
    private lazy var customNavigationItem = CustomNavigationItem(leftButtonText: "취소", rightButtonText: "추가", navigationTitleText: "새로운 미리 알림").then {
        if titleText.text?.count != 0 {
            $0.rightButton.isEnabled = false
            $0.rightButton.setTitleColor(UIColor(red: 80 / 255, green: 152 / 255, blue: 250 / 255, alpha: 1), for: .normal)
        }else {
            $0.rightButton.isEnabled = true
            $0.rightButton.setTitleColor(.gray, for: .normal)
        }
    }
    
    private lazy var titleText = UITextField().then {
        $0.placeholder = "제목"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.borderStyle = .none
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        $0.leftViewMode = .always
    }
    
    private lazy var underLine = UIView().then {
        $0.backgroundColor = .systemGray3
    }
    
    private lazy var contentText = UITextView().then {
        $0.text = "메모"
        $0.textColor = .systemGray2
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.font = .systemFont(ofSize: 17, weight: .light)
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
    }
    
    private lazy var detailTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private lazy var listTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(NewReminderAddListTableViewCell.self, forCellReuseIdentifier: NewReminderAddListTableViewCell.identifier)
    }
    
    // MARK: - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        self.titleText.becomeFirstResponder()
        
        if let index = self.detailTableView.indexPathForSelectedRow  {
            self.detailTableView.deselectRow(at: index, animated: true)
        }
        if let index = self.listTableView.indexPathForSelectedRow  {
            self.listTableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationSetup()
        textViewPlaceholder()
        bindTableView()
        bindView()
        setupLayout()
        bindViewModel()
        
    }
}
// MARK: - extension
extension NewReminderAddViewController {
    private func navigationSetup() {
        self.navigationItem.title = "새로운 미리 알림"
        let rightBtn = UIBarButtonItem(title: "추가", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    private func textViewPlaceholder() {
        contentText.rx.didBeginEditing
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                if (self.contentText.text == "메모") {
                    self.contentText.text = nil
                    self.contentText.textColor = .black
                }
            }).disposed(by: disposeBag)
        
        contentText.rx.didEndEditing
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                if (self.contentText.text == nil || self.contentText.text == "") {
                    self.contentText.text = "메모"
                    self.contentText.textColor = .systemGray2
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        tableDtailData.bind(to: detailTableView.rx.items) { (tableView, index, element) in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = element.leftText
            cell.accessoryType = .disclosureIndicator
            print("element1 : \(element)")
            return cell
        }.disposed(by: disposeBag)
        
        tableData.bind(to: listTableView.rx.items) { (tableView, index, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewReminderAddListTableViewCell") as! NewReminderAddListTableViewCell
            cell.leftTextInCell.text = element.leftText
            cell.rightTextInCell.text = element.rightText
            cell.accessoryType = .disclosureIndicator
            return cell
        }.disposed(by: disposeBag)
    }
    
    private func bindView() {
        customNavigationItem.leftButton.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        detailTableView.rx.itemSelected
            .subscribe { [weak self] indexPath in
                //셀 선택 상태 제거
                self?.detailTableView.deselectRow(at: indexPath, animated: true)
//                self?.navigationController?.pushViewController(NewReminderDetailViewController(), animated: true)
            }.disposed(by: disposeBag)
//
//        listTableView.rx.itemSelected
//            .subscribe { [weak self] indexPath in
//                //셀 선택 상태 제거
////                self?.detailTableView.deselectRow(at: indexPath, animated: true)
//                self?.navigationController?.pushViewController(NewReminderDetailViewController(), animated: true)
//            }.disposed(by: disposeBag)
        
        detailTableView.rx.modelSelected(NewReminderAddList.self)
            .subscribe(onNext: { [weak self] member in
                guard let `self` = self else { return }
                self.navigationController?.pushViewController(NewReminderDetailViewController(), animated: true)
//                self.present(NewReminderDetailViewController(), animated: true, completion: nil)
                print("이동 \(self.navigationController)")
            }).disposed(by: disposeBag)
        
        listTableView.rx.modelSelected(NewReminderAddList.self)
            .subscribe(onNext: { [weak self] member in
                guard let `self` = self else { return }
                self.navigationController?.pushViewController(NewReminderListViewController(), animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func setupLayout() {
        view.addSubviews([ titleText, underLine, contentText, detailTableView, listTableView])
//        customNavigationItem.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(15)
//            $0.leading.equalToSuperview().inset(20)
//            $0.trailing.equalToSuperview().inset(20)
//            $0.height.equalTo(35)
//        }
        titleText.snp.makeConstraints {
//            $0.top.equalTo(customNavigationItem.snp.bottom).inset(-20)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        underLine.snp.makeConstraints {
            $0.top.equalTo(titleText.snp.bottom).inset(10)
            $0.leading.equalToSuperview().inset(40)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        contentText.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }
        detailTableView.snp.makeConstraints {
            $0.top.equalTo(contentText.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        listTableView.snp.makeConstraints {
            $0.top.equalTo(detailTableView.snp.bottom).inset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
    func bindViewModel() {
        let request = NewReminderAddViewModel().transform(input: )
        
        inputTrigger.accept(.start)
    }
}
