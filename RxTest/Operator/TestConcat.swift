//
//  TestConcat.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/21.
//  Copyright © 2018年 赵恒. All rights reserved.
//

import Foundation
import RxSwift

struct TestConcat {
    private static let bag = DisposeBag()
    private static let subject1 = PublishSubject<String>()
    private static let subject2 = PublishSubject<String>()
    
    static func test() {
        let variable = Variable(subject1)
        variable.asObservable()
            .concat()
            .subscribe{print($0)}
            .disposed(by: bag)
        
        subject1.onNext("A")
        subject1.onNext("B")
        variable.value = subject2
        subject2.onNext("C")
        subject1.onNext("E")
        subject2.onNext("🐀")
        subject1.onCompleted()
        subject2.onNext("D")
        subject2.onCompleted()
        
    }
    
    
}
