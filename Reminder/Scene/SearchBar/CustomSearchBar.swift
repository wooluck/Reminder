//
//  SearchBar.swift
//  Reminder
//
//  Created by pineone on 2022/10/05.
//

import UIKit
import RxSwift
import RxCocoa

class CustomSearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    let searchButton = UIButton()
//    let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        
    }
    private func attribute() {
//        searchButton.setTitle("검색", for: .normal)
//        searchButton.setTitleColor(.systemBlue, for: .normal)
//        SearchBar.backgroundColor = .systemGray6
        barTintColor = UIColor.systemGray6
        backgroundColor = UIColor.clear
        searchBarStyle = .minimal
        placeholder = "검색"
    }
    private func layout() {
        self.addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
//            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalToSuperview()
//            $0.height.equalTo(35)
//            $0.centerY.equalToSuperview()
        }
    }
}
