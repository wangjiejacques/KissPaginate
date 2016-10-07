//
//  PaginateViewMock.swift
//  KissPaginate
//
//  Created by WANG Jie on 06/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import KissPaginate

class PaginateViewMock: Paginatable {

    var shouldSuccess: Bool?

    var elements: [Int]!
    var addRefreshTimes = 0
    var endRefreshingTimes = 0
    var startFullScreenRefreshTimes = 0
    var endFullScreenRefreshTimes = 0
    var stopBottomRefreshTimes = 0
    var startBottomRefreshTimes = 0
    var reloadElementsTimes = 0
    var noElementDisplayed: Bool?

    func reset() {
        addRefreshTimes = 0
        endRefreshingTimes = 0
        startFullScreenRefreshTimes = 0
        endFullScreenRefreshTimes = 0
        stopBottomRefreshTimes = 0
        startBottomRefreshTimes = 0
        reloadElementsTimes = 0
        noElementDisplayed = nil
    }

    func addRefresh() {
        addRefreshTimes += 1
    }

    func endRefreshing() {
        endRefreshingTimes += 1
    }

    func startFullScreenRefresh() {
        startFullScreenRefreshTimes += 1
    }

    func endFullScreenRefresh() {
        endFullScreenRefreshTimes += 1
    }

    func stopBottomRefresh() {
        stopBottomRefreshTimes += 1
    }

    func startBottomRefresh() {
        startBottomRefreshTimes += 1
    }

    func reloadElements() {
        reloadElementsTimes += 1
    }

    var getElementsClosure: (_ page: Int, _ successHandler: @escaping GetElementsSuccessHandler, _ failureHandler: @escaping (NSError) -> Void) -> Void {
        return getElementList
    }

    func getElementList(_ page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (_ error: NSError) -> Void) {
        if shouldSuccess! {
            successHandler(self.elements.map { String($0) }, true)
        } else {
            failureHandler(NSError(domain: "kisspaginate", code: 1, userInfo: nil))
        }
    }

    func displayNoElementIfNeeded(noElement: Bool) {
        noElementDisplayed = noElement
    }
}
