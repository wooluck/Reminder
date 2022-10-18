//
//  DayCalendarUIView.swift
//  Reminder
//
//  Created by pineone on 2022/10/13.
//

import Foundation
import UIKit
import FSCalendar

class DayCalendarUIView: UIView {
    
    lazy var calendarView = FSCalendar()
    
    private lazy var underLine = UIView().then {
        $0.backgroundColor = .systemGray3
    }
    
    let dateFormatter = DateFormatter()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        dateFormatter.dateFormat = "yyyy-MM-dd"
        calendarView.delegate = self
        calendarView.dataSource = self
        setupLayout()
        calendarSetup()
//        calendarView.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DayCalendarUIView {
    private func calendarSetup(){
        self.calendarView.appearance.todayColor = UIColor(red: 188/255, green: 224/255, blue: 253/255, alpha: 1)
    }
    
    private func setupLayout() {
        addSubviews([calendarView, underLine])
        calendarView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview()
            $0.height.equalTo(300)
        }
        underLine.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}

extension DayCalendarUIView: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
    }
}
