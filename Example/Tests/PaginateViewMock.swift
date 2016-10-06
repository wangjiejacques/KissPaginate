//
//  PaginateViewMock.swift
//  KissPaginate
//
//  Created by WANG Jie on 06/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import KissPaginate

class PaginateViewMock: PaginateView {

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

    var getElementsClosure: (page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) -> Void {
        return getElementList
    }

    func getElementList(page: Int, successHandler: GetElementsSuccessHandler, failureHandler: (error: NSError) -> Void) {
        successHandler(elements: self.elements.map { String($0) }, hasMoreElements: true)
    }

    func displayNoElementIfNeeded(noElement: Bool) {
        noElementDisplayed = noElement
    }
}
