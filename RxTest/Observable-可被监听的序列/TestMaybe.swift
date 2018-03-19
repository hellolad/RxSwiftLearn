//
//  TestMaybe.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/19.
//  Copyright © 2018年 赵恒. All rights reserved.
//

/**
 Maybe 是 Observable 的另外一个版本。它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。
 
 发出一个元素或者一个 completed 事件或者一个 error 事件
 不会共享状态变化
 */

import Foundation
import RxSwift
import RxCocoa

enum MaybeError: Error {
    case numberError
}

struct TestMaybe {
    static func inputNumber(_ number: Int) -> Maybe<String> {
        return Maybe<String>.create { maybe in
            switch number {
            case 0:
                maybe(.success("Maybe success 数字0"))
            case 1:
                maybe(.completed)
            case 2:
                maybe(.error(MaybeError.numberError))
            default:
                maybe(.error(MaybeError.numberError))
            }
            return Disposables.create()
        }
    }
}

extension Reactive where Base: UILabel {
    public var textColor: Binder<UIColor> {
        return Binder(self.base) { label, textColor in
            label.textColor = textColor
        }
    }
}

