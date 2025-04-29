import XCTest
import Combine
@testable import ToolBox

final class PollerTests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []

    func testPollerFiresImmediatelyWhenConfigured() {
        let expectation = XCTestExpectation(description: "Poller should fire immediately")
        let poller: PollerProtocol = Poller(interval: 1, fireImmediately: true)
        var fireCount = 0

        poller.publisher
            .sink {
                fireCount += 1
                if fireCount == 1 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        poller.start()

        wait(for: [expectation], timeout: 1)
        poller.stop()
    }

    func testPollerDoesNotFireImmediatelyWhenNotConfigured() {
        let expectation = XCTestExpectation(description: "Poller should not fire immediately")
        expectation.isInverted = true

        let poller: PollerProtocol = Poller(interval: 1, fireImmediately: false)

        poller.publisher
            .sink {
                expectation.fulfill()
            }
            .store(in: &cancellables)

        poller.start()

        wait(for: [expectation], timeout: 0.5)
        poller.stop()
    }

    func testPollerFiresAfterInterval() {
        let expectation = XCTestExpectation(description: "Poller should fire after interval")
        let poller: PollerProtocol = Poller(interval: 1, fireImmediately: false)

        poller.publisher
            .sink {
                expectation.fulfill()
            }
            .store(in: &cancellables)

        poller.start()
        wait(for: [expectation], timeout: 2)
        poller.stop()
    }

    @MainActor
    func testPollerFiresImmediatelyThenStops() {
        let immediateExpectation = XCTestExpectation(description: "Should fire immediately")
        let intervalExpectation = XCTestExpectation(description: "Should not fire again")
        intervalExpectation.isInverted = true

        let poller: PollerProtocol = Poller(interval: 0.2, fireImmediately: true)
        var fireCount = 0

        poller.publisher
            .sink {
                fireCount += 1
                if fireCount == 1 {
                    immediateExpectation.fulfill()
                } else {
                    intervalExpectation.fulfill()
                }
            }
            .store(in: &cancellables)

        poller.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            poller.stop()
        }

        wait(for: [immediateExpectation], timeout: 0.1)
        wait(for: [intervalExpectation], timeout: 0.5)
    }
}
