//
//  CustomDetailViewController.swift
//  Reminder
//
//  Created by pineone on 2022/10/07.
//

import Then
import RxSwift
import RxCocoa
import SnapKit

struct detailList {
    var title: String
}

let listDetailDummy: [detailList] = [detailList(title: "Text")]

class CustomDetailViewController: UIViewController {
    var disposeBag = DisposeBag()
    //    let tableDataRelay = BehaviorRelay<[TableList]>(value: [])
    private let tableData = Observable.of(listDetailDummy.map { $0 })
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.text = "미리 알림"
        $0.textColor = .blue
    }
    
    private lazy var detailTableView = UITableView().then {
        $0.register(CustomDetailTableViewCell.self, forCellReuseIdentifier: CustomDetailTableViewCell.identifier)
        //        $0.backgroundColor = .red
    }
    
    private lazy var bottomFixView = UIView()
    private lazy var bottomLeftButton = UIButton().then {
        $0.setTitleColor(UIColor(red: 80 / 255, green: 152 / 255, blue: 250 / 255, alpha: 1), for: .normal)
        $0.setTitle(" 새로운 미리 알림", for: .normal)
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNavigation()
        bindTableView()
        view.backgroundColor = .white
    }
}

    // MARK: - extension
extension CustomDetailViewController {
    private func setupLayout() {
        view.addSubviews([titleLabel, detailTableView, bottomFixView])
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        detailTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(bottomFixView.snp.top)
        }
        bottomFixView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(50)
        }
        
        bottomFixView.addSubviews([bottomLeftButton])
        bottomLeftButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupNavigation() {
        let rightBtn = UIBarButtonItem(image: .init(systemName: "ellipsis.circle"),
                                       style: .plain,
                                       target: self,
                                       action: nil)
        
        let nameAndShapeBtn = UIAction(title: "이름 및 모양",
                                       image: .init(systemName: "pencil")) { _ in print("이름 및 모양 Button Click") }
        
        let shareListBtn = UIAction(title: "공유 목록",
                                    image: .init(systemName: "person.crop.circle.badge.plus")) { _ in print("공유 목록 Button Click") }
        
        let remainderClickBtn = UIAction(title: "미리 알림 선택",
                                         image: .init(systemName: "checkmark.circle")) { _ in print("미리 알림 선택 Button Click") }
        
        let completeBtn = UIAction(title: "완료된 항목 보기",
                                   image: .init(systemName: "eye")) { _ in print("완료된 항목 보기 Button Click") }
        
        let listDeleteBtn = UIAction(title: "목록 삭제",
                                     image: .init(systemName: "trash"),
                                     attributes: .destructive) { _ in print("목록 삭제 Button Click") }
        
        let buttonMenu = UIMenu(title: "",
                                children: [nameAndShapeBtn, shareListBtn, remainderClickBtn, completeBtn, listDeleteBtn])
        
        rightBtn.menu = buttonMenu
        
        self.navigationItem.rightBarButtonItem = rightBtn
        
//        self.navigationController?.navigationBar.topItem?.title = "목록"
    }
    
    private func bindTableView() {
        tableData.bind(to: detailTableView.rx.items) { tableView, row, element in
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDetailTableViewCell") as! CustomDetailTableViewCell
            cell.detailTextInCell.text = element.title
            return cell
        }.disposed(by: disposeBag)
    }
}
