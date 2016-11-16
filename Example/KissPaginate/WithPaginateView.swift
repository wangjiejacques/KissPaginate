//
//  WithPaginateView.swift
//  KissPaginate
//
//  Created by WANG Jie on 06/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import KissPaginate

class WithPaginateView: UIViewController, PaginateView {

    var paginatePresenter: PaginatePresenter!
    var refreshControl: UIRefreshControl!
    var bottomRefresh: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noElementLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paginatePresenter = PaginatePresenter(paginatable: self)
        paginatePresenter.start()
        tableView.dataSource = self
        refreshElements()
    }

    var getElementsClosure: (_ page: Int, _ successHandler: @escaping GetElementsSuccessHandler, _ failureHandler: @escaping (Error) -> Void) -> Void {
        return getElementList
    }

    func getElementList(page: Int, successHandler: @escaping GetElementsSuccessHandler, failureHandler: @escaping (Error) -> Void) {
        let elements = (0...20).map { "page \(page), element index" + String($0) }
        delay(2) {
            successHandler(elements, true)
        }
    }

    func displayNoElementIfNeeded(noElement: Bool) {
        noElementLabel.isHidden = !noElement
    }
}

extension WithPaginateView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let element = getElement(String.self, at: (indexPath as NSIndexPath).row)
        cell.textLabel?.text = element
        if elements.count == (indexPath as NSIndexPath).row + 1 {
            loadNextPage()
        }
        return cell
    }
}
