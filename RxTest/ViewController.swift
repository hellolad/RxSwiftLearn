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
            TestSingle.test()
        }
        
        of("completable") {
            TestCompletable.test()
        }
        
        of("Maybe") {
            TestMaybe.test()
        }
        
        of("AsyncSubject") {
            TestAsyncSubject.test()
        }
        
        of("PublishSubject") {
            TestPublishSubject.test()
        }
        
        of("ReplaySubject") {
            TestReplaySubject.test()
        }
        
        of("BehavioSubject") {
            TestBehavioSubject.test()
        }
        
    }
}

