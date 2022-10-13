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

//struct NewReminderDetailList {
//    var image: String
//    var text: String
//    var dayText: String
//}

//let detailDummy: [NewReminderDetailList] = [NewReminderDetailList(image: "star", text: "날짜", dayText: "오늘")]

class NewReminderDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()
    //    private let tableData = Observable.of(detailDummy.map { $0 })
    
    //    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
    //        $0.register(NewReminderDetailTableViewCell.self, forCellReuseIdentifier: NewReminderDetailTableViewCell.identifier)
    //        $0.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    //    }
    
    var calendarIsOn : Bool = false {
        willSet {
            self.hideCalendar(isHidden: newValue)
            print("calendarIsOn : \(newValue)")
        }
    }

    private lazy var dayView = DayTextUIView()
    private lazy var dayCalendarView = DayCalendarUIView()
    private lazy var timeView = TimeTextUIView()
    private lazy var timeDatePickerView = TimeDatePickerUIView().then {
        $0.isHidden = false
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationSetup()
        setupLayout()
        dayViewHidden()
        
    }
}

extension NewReminderDetailViewController {
    private func navigationSetup() {
        self.navigationItem.title = "세부사항"
        let rightBtn = UIBarButtonItem(title: "추가", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    private func setupLayout() {
        view.addSubviews([dayView, dayCalendarView, timeView, timeDatePickerView])
        dayView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
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
            $0.height.equalTo(40)
        }
    }
    
    private func hideCalendar(isHidden: Bool) {
        print("func hideCalendar: \(isHidden)")
        dayCalendarView.snp.updateConstraints {
            $0.height.equalTo(isHidden ? 300 : 0)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.dayCalendarView.superview?.layoutIfNeeded()
        })
    }
    
    private func dayViewHidden() {
//        if self.dayView.switchBtn.isOn == true {
//            UIView.animate(withDuration: 0.3) {
//                self.dayCalendarView.isHidden = !self.dayCalendarView.isHidden
//            }
//        }
    }

}

