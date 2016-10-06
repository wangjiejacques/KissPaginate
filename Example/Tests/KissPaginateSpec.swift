// https://github.com/Quick/Quick

import Quick
import Nimble
import KissPaginate

/// Given-When-Then is a style of representing tests - or as its advocates would say - specifying a system's behavior using SpecificationByExample.
/// see http://martinfowler.com/bliki/GivenWhenThen.html

class KissPaginateSpec: QuickSpec {
    override func spec() {
        var paginateView: PaginateViewMock!
        var paginatePresenter: PaginatePresenter!

        describe("Given a paginatePresenter") {
            beforeEach {
                paginateView = PaginateViewMock()
                paginatePresenter = PaginatePresenter(paginateView: paginateView)
            }
            context("When the paginatePresenter starts") {
                beforeEach {
                    paginatePresenter.start()
                }
                it("Then the paginateView should add refresh once") {
                    expect(paginateView.addRefreshTimes).to(equal(1))
                }
                it("Then the paginateView should stop bottom refresh once") {
                    expect(paginateView.stopBottomRefreshTimes).to(equal(1))
                }
                it("Then the paginateView should start full screen refresh once") {
                    expect(paginateView.startFullScreenRefreshTimes).to(equal(1))
                }


            }

            context("When the paginatePresenter can getElements") {
                beforeEach {
                    paginateView.elements = [1, 2, 3]
                }

                context("When the paginatePresenter refreshs") {
                    beforeEach {
                        paginatePresenter.refreshElements()
                    }

                    it("Then the paginateView should show refresh") {
                        /// this is done by UIRefreshControl, no need to test.
                    }
                    it("Then the paginateView should end refresh once") {
                        expect(paginateView.endRefreshingTimes).to(equal(1))
                    }
                    it("Then the paginateView should reload elements") {
                        expect(paginateView.reloadElementsTimes).to(equal(1))
                    }
                    it("Then the paginateView should not display the no elements view") {
                        expect(paginateView.noElementDisplayed).to(beFalse())
                    }
                }

                context("When the paginatePresenter loads next page") {
                    beforeEach {
                        paginateView.reset()
                        paginatePresenter.loadNextPage()
                    }
                    it("Then the paginateView should not start bottom refresh once") {
                        expect(paginateView.startBottomRefreshTimes).to(equal(1))
                    }
                    it("Then the paginateView should stop bottom refresh once") {
                        expect(paginateView.stopBottomRefreshTimes).to(equal(1))
                    }
                    it("Then the paginateView should reload elements once") {
                        expect(paginateView.reloadElementsTimes).to(equal(1))
                    }
                }

            }

            context("When the paginatePresenter gets empty elements") {
                beforeEach {
                    paginateView.elements = []
                }

                context("When the paginatePresenter refreshs") {
                    beforeEach {
                        paginatePresenter.refreshElements()
                    }

                    it("Then the paginateView should show refresh") {
                        /// this is done by UIRefreshControl, no need to test.
                    }
                    it("Then the paginateView should end refresh once") {
                        expect(paginateView.endRefreshingTimes).to(equal(1))
                    }
                    it("Then the paginateView should reload elements") {
                        expect(paginateView.reloadElementsTimes).to(equal(1))
                    }
                    it("Then the paginateView should not display the no elements view") {
                        expect(paginateView.noElementDisplayed).to(beTrue())
                    }
                }
            }
        }
    }
}


