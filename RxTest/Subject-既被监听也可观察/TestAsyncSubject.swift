//
//  TestAsyncSubject.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/19.
//  Copyright © 2018年 赵恒. All rights reserved.
//

/**
 AsyncSubject 将在源 Observable 产生完成事件后，发出最后一个元素（仅仅只有最后一个元素），如果源 Observable 没有发出任何元素，只有一个完成事件。那 AsyncSubject 也只有一个完成事件。
 
 它会对随后的观察者发出最终元素。如果源 Observable 因为产生了一个 error 事件而中止， AsyncSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
 */

import Foundation
import RxSwift

struct TestAsyncSubject {
    private static let bag = DisposeBag()
    private static let subject = AsyncSubject<String>()
    
    static func test() {
        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: bag)
        
        subject.onNext("🐩")
        subject.onNext("🐖")
        subject.onNext("🐵")
        subject.onCompleted()
    }
}
