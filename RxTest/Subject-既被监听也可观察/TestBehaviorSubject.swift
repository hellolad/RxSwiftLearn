//
//  TestBehaviorSubject.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/20.
//  Copyright © 2018年 赵恒. All rights reserved.
//

/**
 当观察者对 BehaviorSubject 进行订阅时，它会将源 Observable 中最新的元素发送出来（如果不存在最新的元素，就发出默认元素）。然后将随后产生的元素发送出来。
 如果源 Observable 因为产生了一个 error 事件而中止， BehaviorSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
 */

import Foundation
import RxSwift

struct TestBehavioSubject {
    private static let bag = DisposeBag()
    private static let subject = BehaviorSubject(value: "🏀")
    
    static func test() {
        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: bag)
        
        subject.onNext("🐩")
        subject.onNext("🐱")
        
        subject
            .subscribe{ print("Subscription: 2 Event:", $0) }
            .disposed(by: bag)
        
        subject.onNext("⬆️")
        subject.onNext("⤵️")
        
        subject
            .subscribe { print("Subscription: 3 Event:", $0) }
            .disposed(by: bag)
        
        subject.onNext("🍎")
        subject.onNext("🍌")
        
    }
}
