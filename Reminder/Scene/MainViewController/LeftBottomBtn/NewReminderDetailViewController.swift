//
//  DetailViewController.swift
//  Reminder
//
//  Created by pineone on 2022/10/07.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

struct NewReminderDetailList {
    var leftText: String
    var rightText: String
}

let NewReminderDetailReplyDummy: [NewReminderDetailList] = [NewReminderDetailList(leftText: "반복", rightText: "안 함")]

let NewReminderDetailpriorityDummy: [NewReminderDetailList] = [NewReminderDetailList(leftText: "우선 순위", rightText: "없음")]

class NewReminderDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    let tableReplyData = Observable.of(NewReminderDetailReplyDummy.map { $0 })
    
    let tableProirData = Observable.of(NewReminderDetailpriorityDummy.map { $0 })
    
    private lazy var contentScrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var contentView = UIView()
    
    private lazy var dayView = DayTextUIView()
    
    lazy var dayCalendarView = DayCalendarUIView()
    
    private lazy var timeView = TimeTextUIView()
    
    lazy var timeDatePickerView = TimeDatePickerUIView()
    
    private lazy var replyTable = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(NewReminderDetailReplyCell.self, forCellReuseIdentifier: NewReminderDetailReplyCell.identifier)
        $0.rowHeight = 55
        $0.isScrollEnabled = false
    }
    
    private lazy var locationView = LocationUIView()
    
    private lazy var locationDetailView = LocationDetailUIView()
    
    private lazy var priorityTable = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(NewReminderDetailPriorityCell.self, forCellReuseIdentifier: NewReminderDetailPriorityCell.identifier)
        $0.rowHeight = 55
    }
    
    // MARK: - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.replyTable.indexPathForSelectedRow  {
            self.replyTable.deselectRow(at: index, animated: true)
        }
        if let index = self.priorityTable.indexPathForSelectedRow  {
            self.priorityTable.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationSetup()
        setupLayout()
        bindTableView()
        dayViewHidden()
        timeViewHidden()
    }
}

extension NewReminderDetailViewController {
    private func bindTableView() {
        tableReplyData.bind(to: replyTable.rx.items) { (tableView, index, element) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewReminderDetailReplyCell.identifier) as? NewReminderDetailReplyCell else { return UITableViewCell()}
            
            cell.leftImageInCell.text = element.leftText
            cell.rightTextInCell.text = element.rightText
            cell.accessoryType = .disclosureIndicator
            print("element1 : \(element)")
            return cell
        }.disposed(by: disposeBag)
        
    }
    
    private func navigationSetup() {
        self.navigationItem.title = "세부사항"
        let rightBtn = UIBarButtonItem(title: "추가", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    private func setupLayout() {
        view.addSubviews([contentScrollView])
        contentScrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentScrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            //            $0.height.equalTo(2300)
        }
        
        contentView.addSubviews([dayView, dayCalendarView, timeView, timeDatePickerView, replyTable, locationView, locationDetailView])
        dayView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
            
        }
        dayCalendarView.snp.makeConstraints {
            $0.top.equalTo(dayView.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(0)
        }
        timeView.snp.makeConstraints {
            $0.top.equalTo(dayCalendarView.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
        timeDatePickerView.snp.makeConstraints {
            $0.top.equalTo(timeView.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(0)
        }
        replyTable.snp.makeConstraints {
            $0.top.equalTo(timeDatePickerView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(0)
        }
        locationView.snp.makeConstraints {
            $0.top.equalTo(replyTable.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        locationDetailView.snp.makeConstraints {
            $0.top.equalTo(locationView.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(100)
            $0.bottom.equalToSuperview()
        }
        
    }
}
extension NewReminderDetailViewController {
    private func dayViewHidden() {
        dayView.completion = { [weak self] bool in
            guard let `self` = self else { return }
            self.dayCalendarView.snp.updateConstraints {
                $0.height.equalTo(bool ? 300 : 0)
            }
            self.replyTable.snp.updateConstraints {
                $0.height.equalTo(bool ? 100 : 0)
            }
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func timeViewHidden() {
        timeView.completion = { bool in
            self.timeDatePickerView.snp.updateConstraints {
                $0.height.equalTo(bool ? 50 : 0)
            }
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

