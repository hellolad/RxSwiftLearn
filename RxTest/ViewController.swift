//
//  ViewController.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/19.
//  Copyright © 2018年 赵恒. All rights reserved.
//

import UIKit
import RxSwift

func of(_ str: String, perform: () -> ()) {
    print("---- \(str) ----")
    perform()
    print("")
}

class ViewController: UIViewController {
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        of("single") {
            TestSingle.getHeroListId()
                .subscribe(onSuccess: { json in
                    print(json)
                }, onError: { error in
                    switch error as! SingleError {
                    case .cantParseJSON:
                        print("Single can't parse json")
                    case .getDataError:
                        print("Single get data error")
                    }
                })
                .disposed(by: bag)
        }
        
        
        of("completable") {
            TestCompletable.testCompletable(true)
                .subscribe(onCompleted: {
                    print("Completable is success")
                }, onError: { error in
                    switch error as! CompletableError {
                    case .cantFalse:
                        print("Completable can't false")
                    }
                })
                .disposed(by: bag)
        }
        
        of("Maybe") {
            TestMaybe.inputNumber(0)
                .subscribe(onSuccess: { str in
                    print("Maybe \(str)")
                }, onError: { error in
                    switch error as! MaybeError {
                    case .numberError:
                        print("Maybe number error")
                    }
                }, onCompleted: {
                    print("Maybe completed")
                })
                .disposed(by: bag)
        }
        
        of("AsyncSubject") {
            TestAsyncSubject.test()
        }
        
    }
}

