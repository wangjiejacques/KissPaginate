//
//  PaginatePresenter.swift
//  Pods
//
//  Created by WANG Jie on 05/10/2016.
//
//

import Foundation

public class PaginatePresenter: NSObject {

    public weak var paginatable: Paginatable!
    var elements: [AnyObject] = []
    
    private var hasMoreElements = true
    private var currentPage = 0
    private var isLoadingNextPage = false
    private var isRefreshing = false

    public init(paginatable: Paginatable) {
        self.paginatable = paginatable
    }

    public func start() {
        paginatable.addRefresh()
        paginatable.stopBottomRefresh()
        paginatable.startFullScreenRefresh()
    }

    public func refreshElements() {
        if isRefreshing {
            return
        }
        isRefreshing = true
        paginatable.getElementsClosure(page: 0, successHandler: { (elements, hasMoreElements) in
            self.currentPage = 0
            self.hasMoreElements = hasMoreElements
            self.elements = elements
            self.paginatable.endRefreshing()
            self.paginatable.reloadElements()
            self.isRefreshing = false
            self.paginatable.displayNoElementIfNeeded(elements.count == 0)
        }) { (error) in
            self.paginatable.endRefreshing()
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
        paginatable.startBottomRefresh()
        paginatable.getElementsClosure(page: currentPage+1, successHandler: { (elements, hasMoreElements) in
            self.elements = self.elements + elements
            self.hasMoreElements = hasMoreElements
            self.paginatable.stopBottomRefresh()
            self.paginatable.reloadElements()
            self.currentPage += 1
            self.isLoadingNextPage = false
        }) { (error) in
            self.isLoadingNextPage = false
            self.paginatable.stopBottomRefresh()
        }
    }
}
