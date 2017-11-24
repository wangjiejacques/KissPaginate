//
//  PaginatePresenter.swift
//  Pods
//
//  Created by WANG Jie on 05/10/2016.
//
//

import Foundation

open class PaginatePresenter: NSObject {

    open weak var paginatable: Paginatable?
    public var elements: [Any] = []
    
    fileprivate var hasMoreElements = true
    fileprivate var currentPage = 0
    fileprivate var isLoadingNextPage = false
    fileprivate var isRefreshing = false

    public init(paginatable: Paginatable) {
        self.paginatable = paginatable
    }

    open func start() {
        paginatable?.addRefresh()
        paginatable?.stopBottomRefresh()
    }

    @objc open func refreshElements(sender: Any? = nil) {
        if !(sender is UIRefreshControl) {
            paginatable?.startFullScreenRefresh()
        }
        if isRefreshing {
            return
        }
        isRefreshing = true
        paginatable?.getElementsClosure(0, { (elements, hasMoreElements) in
            self.currentPage = 0
            self.hasMoreElements = hasMoreElements
            self.elements = elements
            self.paginatable?.endRefreshing()
            self.paginatable?.reloadElements()
            self.isRefreshing = false
            self.paginatable?.displayNoElementIfNeeded(noElement: elements.count == 0)
        }) { (error) in
            self.paginatable?.endRefreshing()
            self.isRefreshing = false
        }
    }

    open func cancelRefresh() {
        self.paginatable?.endRefreshing()
        self.isRefreshing = false
    }

    open func loadNextPage() {
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
        paginatable?.startBottomRefresh()
        paginatable?.getElementsClosure(currentPage+1, { (elements, hasMoreElements) in
            self.elements = self.elements + elements
            self.hasMoreElements = hasMoreElements
            self.paginatable?.stopBottomRefresh()
            self.paginatable?.reloadElements()
            self.currentPage += 1
            self.isLoadingNextPage = false
        }) { (error) in
            self.isLoadingNextPage = false
            self.paginatable?.stopBottomRefresh()
        }
    }
}
