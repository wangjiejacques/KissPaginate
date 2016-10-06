//
//  PaginatePresenter.swift
//  Pods
//
//  Created by WANG Jie on 05/10/2016.
//
//

import Foundation

public class PaginatePresenter: NSObject {

    public weak var paginateView: PaginateView!
    var elements: [AnyObject] = []
    
    private var hasMoreElements = true
    private var currentPage = 0
    private var isLoadingNextPage = false
    private var isRefreshing = false

    public init(paginateView: PaginateView) {
        self.paginateView = paginateView
    }

    public override init() {

    }

    public func start() {
        paginateView.addRefresh()
        paginateView.stopBottomRefresh()
        paginateView.startFullScreenRefresh()
    }

    public func refreshElements() {
        if isRefreshing {
            return
        }
        isRefreshing = true
        paginateView.getElementsClosure(page: 0, successHandler: { (elements, hasMoreElements) in
            self.currentPage = 0
            self.hasMoreElements = hasMoreElements
            self.elements = elements
            self.paginateView.endRefreshing()
            self.paginateView.reloadElements()
            self.isRefreshing = false
            self.paginateView.displayNoElementIfNeeded(elements.count == 0)
        }) { (error) in
            self.paginateView.endRefreshing()
            self.isRefreshing = false
        }
    }

    public func loadNextPage() {
        if isRefreshing {
            return
        }
        if isLoadingNextPage {
            return
        }
        guard hasMoreElements else {
            return
        }
        isLoadingNextPage = true
        paginateView.startBottomRefresh()
        paginateView.getElementsClosure(page: currentPage+1, successHandler: { (elements, hasMoreElements) in
            self.elements = self.elements + elements
            self.hasMoreElements = hasMoreElements
            self.paginateView.stopBottomRefresh()
            self.paginateView.reloadElements()
            self.currentPage += 1
            self.isLoadingNextPage = false
        }) { (error) in
            self.isLoadingNextPage = false
            self.paginateView.stopBottomRefresh()
        }
    }
}
