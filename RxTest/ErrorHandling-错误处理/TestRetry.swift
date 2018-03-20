//
//  TestRetry.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/20.
//  Copyright © 2018年 赵恒. All rights reserved.
//

import Foundation
import RxSwift

enum RetryError: Error {
    case errorNumber
}

struct TestRetry {
    private static let bag = DisposeBag()
    private static let retryCount = 3   // 尝试次数
    
    static func test() {
        var index = 1   // 当前尝试次数
        let get3 = Single<Bool>.create(subscribe: { single in
            print("index = ", index)
            if index >= 3 {
                single(.success(true))
            } else {
                index += 1
                single(.error(RetryError.errorNumber))
            }
            return Disposables.create()
        })
        get3.asObservable()
            .retry(retryCount)
            .subscribe(onNext: { int in
                print("Retry int \(int)")
            },onError: { error in
                switch (error as! RetryError) {
                case .errorNumber:
                    print("Retry Error Number!!!")
                }
            },onCompleted: {
                print("Retry completed")
            })
            .disposed(by: bag)
    }
    
}
