//
//  ObservableType.swift
//  UIViewController_Rx
//
//  Created by Takehito Koshimizu on 2017/08/13.
//  Copyright © 2017年 Takehito Koshimizu. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension ObservableType where Self.E: Collection {
    func first<T>() -> Observable<T> {
        return map { $0.first as? T }.unwrapped()
    }
}

extension ObservableType {
    func void() -> Observable<Void> {
        return map { _ in () }
    }
}
