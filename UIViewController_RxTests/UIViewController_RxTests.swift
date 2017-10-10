//
//  UIViewController_RxTests.swift
//  UIViewController_RxTests
//
//  Created by Takehito Koshimizu on 2017/08/13.
//  Copyright © 2017年 Takehito Koshimizu. All rights reserved.
//

import RxBlocking
import RxCocoa
import RxSwift
import RxTest
import XCTest
import UIKit

@testable import UIViewController_Rx

class UIViewController_RxTests: XCTestCase {

    var vc: UIViewController?
    let bag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        vc = UIViewController()
        _ = vc?.view
    }
    
    override func tearDown() {
        super.tearDown()
        vc = nil
    }
    
    func test() {
        guard let vc = vc else { return XCTFail() }
        wait(
            for: [
                expectation(vc.rx.viewWillAppear,    vc.viewWillAppear,    true, "viewWillAppear"),
                expectation(vc.rx.viewDidAppear,     vc.viewDidAppear,     true, "viewDidAppear"),
                expectation(vc.rx.viewWillDisappear, vc.viewWillDisappear, true, "viewWillDisappear"),
                expectation(vc.rx.viewDidDisappear,  vc.viewDidDisappear,  true, "viewDidDisappear"),
            ],
            timeout: 1.0)
    }
}

private extension UIViewController_RxTests {

    func expectation<T: Equatable>(
        _ observable: Observable<T>,
        _ function: (_ parameter: T) -> Void = { _ in },
        _ parameter: T,
        _ description: String = String()) -> XCTestExpectation {

        let expectation = XCTestExpectation(description: description)
        observable
            .bind(onNext:{
                XCTAssert($0==parameter)
                expectation.fulfill()
            })
            .addDisposableTo(bag)

        function(parameter)

        return expectation
    }
}
