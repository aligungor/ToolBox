import Foundation
import Combine

// MARK: - Protocol

/// A protocol that defines a timer-based polling mechanism using Combine.
///
/// Classes conforming to this protocol emit `Void` events at a regular interval.
///
/// Example usage:
/// ```swift
/// class MyService {
///     private let poller: PollerProtocol = Poller(interval: 5)
///     private var cancellable: AnyCancellable?
///
///     func startPolling() {
///         cancellable = poller.publisher
///             .sink { _ in
///                 print("Polled!")
///             }
///         poller.start()
///     }
///
///     func stopPolling() {
///         poller.stop()
///         cancellable?.cancel()
///     }
/// }
/// ```
public protocol PollerProtocol {
    /// A Combine publisher that emits a `Void` value at every poll interval.
    var publisher: AnyPublisher<Void, Never> { get }

    /// Starts the polling process.
    func start()

    /// Stops the polling process.
    func stop()
}

// MARK: - Class

/// A concrete implementation of `PollerProtocol` that emits events on a timed interval.
///
/// Emits `Void` through a Combine publisher at a given interval on the main run loop.
/// You can configure whether it fires immediately upon start.
///
/// Example:
/// ```swift
/// let poller = Poller(interval: 10, fireImmediately: true)
/// let cancellable = poller.publisher
///     .sink {
///         print("Poll fired!")
///     }
/// poller.start()
/// // Don't forget to call `poller.stop()` and `cancellable.cancel()` when done.
/// ```
open class Poller: PollerProtocol {
    // MARK: - Variables

    /// Internal subscription to the timer publisher.
    private var timerSubscription: AnyCancellable?

    /// Polling interval in seconds. Must be greater than zero.
    private let interval: TimeInterval

    /// Whether the poller should emit an event immediately when started.
    private let fireImmediately: Bool

    /// Subject backing the public `publisher`.
    private let subject = PassthroughSubject<Void, Never>()

    /// A Combine publisher that emits a `Void` value at every interval.
    public var publisher: AnyPublisher<Void, Never> {
        subject.eraseToAnyPublisher()
    }

    // MARK: - Lifecycle

    /// Initializes a new poller with a specified interval and behavior.
    ///
    /// - Parameters:
    ///   - interval: Polling interval in seconds. Must be > 0.
    ///   - fireImmediately: Whether the poller should emit immediately on `start()`.
    public init(interval: TimeInterval, fireImmediately: Bool = false) {
        precondition(interval > 0, "Interval must be greater than 0 seconds.")
        self.interval = interval
        self.fireImmediately = fireImmediately
    }

    // MARK: - Protocol Implementation

    /// Starts the timer and begins publishing at the defined interval.
    open func start() {
        if fireImmediately {
            subject.send(())
        }

        timerSubscription = Timer
            .publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.subject.send(())
            }
    }

    /// Stops the timer and terminates publishing.
    open func stop() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
}
