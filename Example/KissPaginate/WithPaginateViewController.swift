//
//  ViewController.swift
//  KissPaginate
//
//  Created by WANG Jie on 10/05/2016.
//  Copyright (c) 2016 WANG Jie. All rights reserved.
//

import UIKit
import KissPaginate

class WithPaginateViewController: PaginateViewController {

    @IBOutlet weak var noElementLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        refreshElements(sender: nil)
    }

    override var getElementsClosure: (_ page: Int, _ successHandler: @escaping GetElementsSuccessHandler, _ failureHandler: @escaping (Error) -> Void) -> Void {
        return getElementList
    }

    func getElementList(_ page: Int, successHandler: @escaping GetElementsSuccessHandler, failureHandler: (_ error: Error) -> Void) {
        let elements = (0...20).map { "page \(page), element index" + String($0) }
        delay(2) {
            successHandler(elements, true)
        }
    }

    override func displayNoElementIfNeeded(noElement: Bool) {
        noElementLabel.isHidden = !noElement
    }
}

extension WithPaginateViewController: UITableViewDataSource {
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
