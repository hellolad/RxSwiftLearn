//
//  TestCombineLatest.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/21.
//  Copyright © 2018年 赵恒. All rights reserved.
//

import Foundation
import RxSwift

/**
 “当多个 Observables 中任何一个发出一个元素，就发出一个元素。这个元素是由这些 Observables 中最新的元素，通过一个函数组合起来的”
 CombineLatest操作符将多个Observables中最新的元素通过一个函数结合起来，然后将这个组合的结果发出来。这些源Observable中任何一个元素发出一个元素，他都会发出一个元素。
 */

struct TestCombineLatest {
    private static let bag = DisposeBag()
    private static let subject1 = PublishSubject<String>()
    private static let subject2 = PublishSubject<String>()
    
    static func test() {
        Observable
            .combineLatest(subject1, subject2, resultSelector: +)
            .subscribe { print($0) }
            .disposed(by: bag)
        
        subject1.onNext("A")
        subject2.onNext("1")
        subject2.onNext("2")
        subject1.onNext("B")
        subject1.onNext("C")
    }
}
