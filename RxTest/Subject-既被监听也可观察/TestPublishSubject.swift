//
//  TestPublishSubject.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/19.
//  Copyright © 2018年 赵恒. All rights reserved.
//

/**
 PublishSubject 将对观察者发送订阅后产生的元素，而在订阅前发出的元素将不会发送给观察者。
 如果源 Observable 因为产生了一个 error 事件而中止， PublishSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
 */

import Foundation
import RxSwift

struct TestPublishSubject {
    private static let bag = DisposeBag()
    private static let subject = PublishSubject<String>()
    
    static func test() {
        subject
            .subscribe(onNext: { str in
                print("PublishSubject1 \(str)")
            }, onError: { error in
                print("PublishSubject1 error \(error)")
            }, onCompleted: {
                print("PublishSubject1 completed")
            }, onDisposed: {
                print("PublishSubject1 onDisposed")
            })
            .disposed(by: bag)
        
        subject.onNext("🐶")
        subject.onNext("🐔")
        
        subject
            .subscribe(onNext: { str in
                print("PublishSubject2 \(str)")
            }, onError: { error in
                print("PublishSubject2 error \(error)")
            }, onCompleted: {
                print("PublishSubject2 completed")
            }, onDisposed: {
                print("PublishSubject2 onDisposed")
            })
            .disposed(by: bag)
        
        subject.onNext("🐯")
        subject.onNext("🦁")
        

    }
}
