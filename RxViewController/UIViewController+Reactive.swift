//
//  UIViewController+Reactive.swift
//  RxViewController
//
//  Created by Takehito Koshimizu on 2017/03/05.
//  Copyright © 2017年 Takehito Koshimizu. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

public extension Reactive where Base: UIViewController {

    public var viewWillAppear: Observable<Bool> {
        return _sentMessage(#selector(base.viewWillAppear(_:)))
    }

    public var viewDidAppear: Observable<Bool> {
        return _sentMessage(#selector(base.viewDidAppear(_:)))
    }

    public var viewWillDisappear: Observable<Bool> {
        return _sentMessage(#selector(base.viewWillDisappear(_:)))
    }

    public var viewDidDisappear: Observable<Bool> {
        return _sentMessage(#selector(base.viewDidDisappear(_:)))
    }

    public var viewWillLayoutSubviews: Observable<Void> {
        return _sentMessage(#selector(base.viewWillLayoutSubviews))
    }

    public var viewDidLayoutSubviews: Observable<Void> {
        return _sentMessage(#selector(base.viewDidLayoutSubviews))
    }

    public var prepareForSegue: Observable<UIViewController> {
        let segue: Observable<UIStoryboardSegue> = _sentMessage(#selector(base.prepare(for:sender:)))
        return segue.map { $0.destination }.shareReplay(1)
    }
}

public extension Reactive where Base: UIViewController {
    public func observer<T>(binding: @escaping (Base, T) -> Void) -> UIBindingObserver<Base, T> {
        return UIBindingObserver<Base, T>(UIElement: base, binding: binding)
    }
}

public extension ReactiveCompatible where Self: UIViewController {
    public typealias BindingObserver<T> = UIBindingObserver<Self, T>
}

extension Reactive where Base: AnyObject {

    func _sentMessage<T>(_ selector: Selector) -> Observable<T> {
        return sentMessage(selector).map { ($0.first as? T)! }.shareReplay(1)
    }

    func _sentMessage(_ selector: Selector) -> Observable<Void> {
        return sentMessage(selector).map { _ in () }.shareReplay(1)
    }
}
