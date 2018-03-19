//
//  TestReplaySubject.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/19.
//  Copyright © 2018年 赵恒. All rights reserved.
//

import Foundation
import RxSwift

struct TestReplaySubject {
    private static let bag = DisposeBag()
    private static let subject = ReplaySubject<String>.create(bufferSize: 1)
    
    static func test() {
        subject
            .subscribe(onNext: { str in
                print("ReplaySubject1: \(str)")
            }, onError: { error in
                print("ReplaySubject1: \(error)")
            }, onCompleted: {
                print("ReplaySubject1: completed")
            }, onDisposed: {
                print("ReplaySubject1: disposed")
            })
            .disposed(by: bag)
        
        subject.onNext("🐩")
        subject.onNext("🐔")
        
        subject
            .subscribe(onNext: { str in
                print("ReplaySubject1: \(str)")
            }, onError: { error in
                print("ReplaySubject1: \(error)")
            }, onCompleted: {
                print("ReplaySubject1: completed")
            }, onDisposed: {
                print("ReplaySubject1: disposed")
            })
            .disposed(by: bag)
        
        subject.onNext("🐯")
        subject.onNext("🦁")
    }
}
