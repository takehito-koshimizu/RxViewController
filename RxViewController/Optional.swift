//
//  Optional.swift
//  UIViewController_Rx
//
//  Created by Takehito Koshimizu on 2017/08/13.
//  Copyright © 2017年 Takehito Koshimizu. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol Optionable: ExpressibleByNilLiteral {
    associatedtype Wrapped
    var asOptional: Wrapped? { get }
}

extension Optional: Optionable {
    var asOptional: Wrapped? {
        return self
    }
}

extension ObservableType where E: Optionable {

    func unwrapped() -> Observable<E.Wrapped> {
        return flatMap { Observable.from(optional:$0.asOptional) }
    }
}
