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

class NewReminderDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()

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

    private lazy var dayView = DayTextUIView()
    private lazy var dayCalendarView = DayCalendarUIView()
    private lazy var timeView = TimeTextUIView()
    private lazy var timeDatePickerView = TimeDatePickerUIView().then {
        $0.isHidden = false
    }
    
    private lazy var replyTable = UITableView()
    
    
    
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
    }
    
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

