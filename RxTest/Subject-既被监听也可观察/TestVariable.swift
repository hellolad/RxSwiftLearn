//
//  TestVariable.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/20.
//  Copyright © 2018年 赵恒. All rights reserved.
//

/**
 在 Swift 中我们经常会用 var 关键字来声明变量。RxSwift 提供的 Variable 实际上是 var 的 Rx 版本，你可以将它看作是 RxVar。
 Variable 封装了一个 BehaviorSubject，所以它会持有当前值，并且 Variable 会对新的观察者发送当前值。它不会产生 error 事件。Variable 在 deinit 时，会发出一个 completed 事件。
 */

import Foundation
import RxSwift

protocol Catable {
    var name: String { get set }
    var age: Int { get set }
}
struct Cat: Catable {
    var name: String
    var age: Int
    
    func eat() {
        print("\(name) eat.")
    }
}

struct TestVariable {
    private static let cat: Variable<Cat?> = Variable(nil)
    private static let bag = DisposeBag()
    
    private static func generatorCat() -> Cat {
        return Cat(name: "Hua", age: 2)
    }
    
    static func test() {
        cat.asObservable()
            .subscribe(onNext: { ct in
                ct?.eat()
            })
            .disposed(by: bag)
        cat.value = generatorCat()
    }
}
