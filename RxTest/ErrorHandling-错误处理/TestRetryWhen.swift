//
//  TestRetryWhen.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/20.
//  Copyright © 2018年 赵恒. All rights reserved.
//

import Foundation
import RxSwift

struct TestRetryWhen {
    private static let bag = DisposeBag()
    private static var retryCount = 1           // 当前重试次数
    private static let maxRetryCount = 5        // 最多重试次数
    private static let retryDelay: Double = 3   // 多少秒重试一次
    
    static func test() {
        let get5 = Single<Bool>.create(subscribe: { single in
            if retryCount == maxRetryCount {
                retryCount = 1
                single(.success(true))
            } else {
                print("当前重试次数: ", retryCount)
                retryCount += 1
                single(.error(RetryError.errorNumber))
            }
            return Disposables.create()
        })
        
        get5.asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .retryWhen { (error) -> Observable<Int> in
                return error.flatMap({ (er) -> Observable<Int> in
                    guard retryCount < maxRetryCount else {
                        return Observable.error(er)
                    }
                    return Observable.timer(retryDelay, scheduler: MainScheduler.instance)
                })
            }
            .subscribe(onNext: { bool in
                print("bool =", bool)
            }, onError: { error in
                switch (error as! RetryError) {
                case .errorNumber:
                    print("number error")
                }
            }, onCompleted: {
                print("completed")
            })
            .disposed(by: bag)
    }
    
}
