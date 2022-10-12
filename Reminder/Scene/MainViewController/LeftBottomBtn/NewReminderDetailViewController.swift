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
    
    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(NewReminderDetailTableViewCell.self, forCellReuseIdentifier: NewReminderDetailTableViewCell.identifier)
    }
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationSetup()
        setupLayout()
        
        tableView.rowHeight = UITableView.automaticDimension
        

        
    }
}

extension NewReminderDetailViewController {
    private func navigationSetup() {
        self.navigationItem.title = "세부사항"
        let rightBtn = UIBarButtonItem(title: "추가", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    private func setupLayout() {
        view.addSubviews([tableView])
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
