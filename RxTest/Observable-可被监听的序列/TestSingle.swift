//
//  TestSingle.swift
//  RxTest
//
//  Created by 赵恒 on 2018/3/19.
//  Copyright © 2018年 赵恒. All rights reserved.
//

/**
 Single 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件。
 
 发出一个元素，或一个 error 事件
 不会共享状态变化
 */

import Foundation
import RxSwift

enum SingleError: Error {
    case getDataError
    case cantParseJSON
}

struct TestSingle {
    static func getHeroListId() -> Single<[String: Any]> {
        return Single<[String: Any]>.create {single in
            let url = "ttps://g37simulator.webapp.163.com/get_heroid_list?rarity=0&page=1&per_page=1000"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) {
                data, _, error in
                if let _ = error {
                    return single(.error(SingleError.getDataError))
                    
                }
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                    let result = json as? [String: Any] else {
                        return single(.error(SingleError.cantParseJSON))
                }
                return single(.success(result))
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}

