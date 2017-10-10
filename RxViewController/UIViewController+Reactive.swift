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

public extension ReactiveCompatible where Self: UIViewController {
    public typealias BindingObserver<T> = UIBindingObserver<Self, T>
}

public extension Reactive where Base: UIViewController {

    public var viewWillAppear: Observable<Bool> {
        return sent(#selector(base.viewWillAppear(_:)))
    }

    public var viewDidAppear: Observable<Bool> {
        return sent(#selector(base.viewDidAppear(_:)))
    }

    public var viewWillDisappear: Observable<Bool> {
        return sent(#selector(base.viewWillDisappear(_:)))
    }

    public var viewDidDisappear: Observable<Bool> {
        return sent(#selector(base.viewDidDisappear(_:)))
    }

    public var prepareForSegue: Observable<UIStoryboardSegue> {
        return sent(#selector(base.prepare(for:sender:)))
    }

    public var viewWillLayoutSubviews: Observable<Void> {
        return sent(#selector(base.viewWillLayoutSubviews))
    }

    public var viewDidLayoutSubviews: Observable<Void> {
        return sent(#selector(base.viewDidLayoutSubviews))
    }

    public func observer<T>(binding: @escaping (Base, T) -> Void) -> UIBindingObserver<Base, T> {
        return UIBindingObserver<Base, T>(UIElement: base, binding: binding)
    }
}
