//
//  TestCatchError.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/21.
//  Copyright © 2018年 赵恒. All rights reserved.
//

import Foundation
import RxSwift

enum CatchErrorError: Error {
    case cathError
}

/** 捕获到一个错误之后用另一个序列代替继续操作  */
struct TestCatchError {
    private static let bag = DisposeBag()
    private static let subject1 = PublishSubject<String>()
    private static let subject2 = PublishSubject<String>()
    
    static func test() {
        subject1
            .catchError {
                print("Error", $0)
                return subject2
            }
            .subscribe { print($0) }
            .disposed(by: bag)
        
        subject1.onNext("1")
        subject1.onNext("2")
        subject1.onNext("3")
        subject1.onNext("4")
        subject1.onError(CatchErrorError.cathError)
        subject2.onNext("5")
    }
}

struct TestCatchErrorJustReturn {
    private static let bag = DisposeBag()
    private static let subject1 = PublishSubject<String>()
    
    static func test() {
        subject1
            .catchErrorJustReturn("😢")
            .subscribe { print($0) }
            .disposed(by: bag)
        
        subject1.onNext("A")
        subject1.onNext("B")
        subject1.onNext("C")
        subject1.onNext("D")
        subject1.onError(CatchErrorError.cathError)
        subject1.onNext("E")
    }
}
