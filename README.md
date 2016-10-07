# KissPaginate

[![CI Status](http://img.shields.io/travis/WANGjieJacques/KissPaginate.svg?style=flat)](https://travis-ci.org/WANGjieJacques/KissPaginate)
[![Version](https://img.shields.io/cocoapods/v/KissPaginate.svg?style=flat)](http://cocoapods.org/pods/KissPaginate)
[![License](https://img.shields.io/cocoapods/l/KissPaginate.svg?style=flat)](http://cocoapods.org/pods/KissPaginate)
[![Platform](https://img.shields.io/cocoapods/p/KissPaginate.svg?style=flat)](http://cocoapods.org/pods/KissPaginate)
[![codecov](https://codecov.io/gh/WANGjieJacques/KissPaginate/branch/master/graph/badge.svg)](https://codecov.io/gh/WANGjieJacques/KissPaginate)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
### Inherit from PaginateViewController
```swift
class ViewController: PaginateViewController {

    @IBOutlet weak var noElementLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        refreshElements()
    }

    override var getElementsClosure: (_ page: Int, _ successHandler: @escaping GetElementsSuccessHandler, _ failureHandler: @escaping (NSError) -> Void) -> Void {
        return getElementList
    }

    func getElementList(_ page: Int, successHandler: @escaping GetElementsSuccessHandler, failureHandler: (_ error: NSError) -> Void) {
        let elements = (0...20).map { "page \(page), element index" + String($0) }
        delay(2) {
            successHandler(elements, true)
        }
    }

    override func displayNoElementIfNeeded(noElement: Bool) {
        noElementLabel.isHidden = !noElement
    }
}

extension ViewController: UITableViewDataSource {
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
```

### Inherit from PaginateView

if your ViewController already has a parent class, you can inherit from the protocal `PaginateView`

```swift  
class PaginateView: UIViewController, PaginateView {

    var presenter: PaginatePresenter!
    var refreshControl: UIRefreshControl!
    var bottomRefresh: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noElementLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PaginatePresenter(paginatable: self)
        presenter.start()
        tableView.dataSource = self
        refreshElements()
    }

    var getElementsClosure: (_ page: Int, _ successHandler: @escaping GetElementsSuccessHandler, _ failureHandler: @escaping (NSError) -> Void) -> Void {
        return getElementList
    }

    func getElementList(page: Int, successHandler: @escaping GetElementsSuccessHandler, failureHandler: @escaping (NSError) -> Void) {
        let elements = (0...20).map { "page \(page), element index" + String($0) }
        delay(2) {
            successHandler(elements, true)
        }
    }

    func displayNoElementIfNeeded(noElement: Bool) {
        noElementLabel.isHidden = !noElement
    }
}

extension PaginateView: UITableViewDataSource {
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

```
## Requirements

## Installation

KissPaginate is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KissPaginate'
```

## Author

WANG Jie, jacques09125715@gmail.com

## License

KissPaginate is available under the MIT license. See the LICENSE file for more info.
