//
//  TestCompletable.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/19.
//  Copyright © 2018年 赵恒. All rights reserved.
//

/**
 Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件。
 
 发出零个元素
 发出一个 completed 事件或者一个 error 事件
 不会共享状态变化
 */

import Foundation
import RxSwift

enum CompletableError: Error {
    case cantFalse
}

struct TestCompletable {
    static func testCompletable(_ flag: Bool) -> Completable {
        return Completable.create(subscribe: { completable in
            if flag {
                completable(.completed)
            } else {
                completable(.error(CompletableError.cantFalse))
            }
            
            return Disposables.create()
        })
        
    }
}
