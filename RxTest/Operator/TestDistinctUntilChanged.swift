//
//  TestDistinctUntilChanged.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/26.
//  Copyright © 2018年 赵恒. All rights reserved.
//

/**
阻止发出两个相邻的元素
 */

import Foundation
import RxSwift

struct TestDistinctUntilChanged {
    static let bag = DisposeBag()
    static let subject = PublishSubject<String>()
    
    static func test() {
        subject
            .distinctUntilChanged()
            .subscribe(onNext: { val in
                print("val :\(val)")
            })
            .disposed(by: bag)
        
        subject.onNext("A")
        subject.onNext("B")
        subject.onNext("C")
        subject.onNext("D")
        subject.onNext("D")
        subject.onNext("E")
    }
}
