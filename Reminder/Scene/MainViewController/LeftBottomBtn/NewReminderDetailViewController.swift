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

    var calendarIsOn : Bool = false {
        willSet {
            self.hideCalendar(notHidden: newValue)
            print("calendarIsOn : \(newValue)")
        }
    }
    
    var timeIsOn: Bool = false {
        willSet {
            self.hideTime(notHidden: newValue)
            print("timeIsOn : \(newValue)")
        }
    }
    
    private lazy var contentScrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
//        $0.backgroundColor = .purple
    }
    private lazy var contentView = UIView()

    private lazy var dayView = DayTextUIView()
    private lazy var dayCalendarView = DayCalendarUIView()
    private lazy var timeView = TimeTextUIView()
    private lazy var timeDatePickerView = TimeDatePickerUIView().then {
        $0.isHidden = false
    }
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
        
//        tableProirData.bind(to: priorityTable.rx.items) { (tableView, index, element) in
//            let cell = tableView.dequeueReusableCell(withIdentifier: NewReminderDetailPriorityCell.identifier) as! NewReminderAddListTableViewCell
//            cell.leftTextInCell.text = element.leftText
//            cell.rightTextInCell.text = element.rightText
//            cell.accessoryType = .disclosureIndicator
//            return cell
//        }.disposed(by: disposeBag)
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
            $0.height.equalTo(2300)
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
            $0.height.equalTo(300)
//            $0.bottom.equalTo(timeView.snp.top)
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
//            $0.height.equalTo(0)
        }
        replyTable.snp.makeConstraints {
            $0.top.equalTo(timeDatePickerView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
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
        }
        
    }
}
extension NewReminderDetailViewController {
    private func hideCalendar(notHidden: Bool) {
        print("func hideCalendar: \(notHidden)")
        DispatchQueue.main.async {
            self.dayCalendarView.snp.updateConstraints {
                $0.height.equalTo(notHidden ? 300 : 0)
            }
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func hideTime(notHidden: Bool) {
        self.timeDatePickerView.snp.updateConstraints {
            $0.height.equalTo(notHidden ? 40 : 0)
        }
    }
    
    private func dayViewHidden() {
//        if self.dayView.switchBtn.isOn == true {
//            UIView.animate(withDuration: 0.3) {
//                self.dayCalendarView.isHidden = !self.dayCalendarView.isHidden
//            }
//        }
    }
}

