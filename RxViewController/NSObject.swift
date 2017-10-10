//
//  NSObject.swift
//  UIViewController_Rx
//
//  Created by Takehito Koshimizu on 2017/08/13.
//  Copyright © 2017年 Takehito Koshimizu. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension Reactive where Base: NSObject {

    func sent<T>(_ selector: Selector) -> Observable<T> {
        return sentMessage(selector).first()
    }

    func sent(_ selector: Selector) -> Observable<Void> {
        return sentMessage(selector).void()
    }

    func invoked<T>(_ selector: Selector) -> Observable<T> {
        return methodInvoked(selector).first()
    }

    func invoked(_ selector: Selector) -> Observable<Void> {
        return methodInvoked(selector).void()
    }
}
