//
//  NewReminderAddViewModel.swift
//  Reminder
//
//  Created by pineone on 2022/10/20.
//

import Foundation
import RxSwift
import RxCocoa

enum ActionType {
    case start
    case write
}

class NewReminderAddViewModel {
    var disposeBag = DisposeBag()
    
    private let outputTitle = BehaviorRelay<String>(value: "")
    private let outputDescription = BehaviorRelay<String>(value: "")
    
    struct Input {
        let inputTrigger: PublishRelay<ActionType>
        let inputTitle: PublishRelay<String>
        let inputDescription: PublishRelay<String>
    }
    
    struct Output {
        let outputTitle: Observable<String>
        let outputDescription: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        input.inputTrigger
            .bind(onNext: actionType(type:))
            .disposed(by: disposeBag)
            
//        input.inputTitle
//            .bind(to: outputTitle)
//            .disposed(by: disposeBag)
//
//        input.inputDescription
//            .bind(to: outputDescription)
//            .disposed(by: disposeBag)
        
        return Output(outputTitle: outputTitle.asObservable(), outputDescription: outputDescription.asObservable())
    }
}

extension NewReminderAddViewModel {
    private func actionType(type: ActionType) {
        switch type {
        case .start :
            print("start click")
            
        case .write :
            print("write click")
        }
    }
}
