//
//  TestDebounce.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/21.
//  Copyright © 2018年 赵恒. All rights reserved.
//

/**
 过滤掉高频产生的元素 适用于一直点击某个按钮造成的连续多个页面进行的跳转
 */
 

import Foundation
import RxSwift

struct TestDebounce {
    private static let bag = DisposeBag()
    private static let subject = PublishSubject<String>()
    
    static func test() {
        subject
            .debounce(0.1, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: bag)
        
        subject.onNext("A")
        subject.onNext("B")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            subject.onNext("C")
            subject.onNext("D")
            subject.onNext("E")
            subject.onNext("F")
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            subject.onNext("G")
            subject.onNext("H")
            subject.onNext("I")
        }
        
    }
}
