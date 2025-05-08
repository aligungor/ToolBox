//
//  DependencyInjector.swift
//

import Foundation

/// A simple, thread-safe, type-based dependency injection container.
///
/// ### Example Usage (SwiftUI):
/// ```swift
/// protocol UserServiceProtocol {
///     func fetchUser() -> String
/// }
///
/// class UserService: UserServiceProtocol {
///     func fetchUser() -> String { "John Doe" }
/// }
///
/// @main
/// struct MyApp: App {
///     @Provider var userService = UserService() as UserServiceProtocol
///
///     var body: some Scene {
///         WindowGroup { ContentView() }
///     }
/// }
///
/// struct ContentView: View {
///     @Inject var userService: UserServiceProtocol
///     @LazyInject var lazyService: UserServiceProtocol
///     @OptionalInject var optionalService: UserServiceProtocol?
///
///     var body: some View {
///         Text(userService.fetchUser())
///     }
/// }
/// ```
///
/// ### Example Usage (UIKit):
/// ```swift
/// protocol AnalyticsServiceProtocol {
///     func log(event: String)
/// }
///
/// class AnalyticsService: AnalyticsServiceProtocol {
///     func log(event: String) {
///         print("Logged event: \(event)")
///     }
/// }
///
/// class AppDelegate: UIResponder, UIApplicationDelegate {
///     func application(
///         _ application: UIApplication,
///         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
///     ) -> Bool {
///         DependencyInjector.shared.register(AnalyticsService() as AnalyticsServiceProtocol)
///         return true
///     }
/// }
///
/// class HomeViewController: UIViewController {
///     @Inject var analytics: AnalyticsServiceProtocol
///     @LazyInject var lazyAnalytics: AnalyticsServiceProtocol
///     @OptionalInject var optionalAnalytics: AnalyticsServiceProtocol?
///
///     override func viewDidLoad() {
///         super.viewDidLoad()
///         analytics.log(event: "Home screen loaded")
///         optionalAnalytics?.log(event: "Optional logging")
///     }
/// }
/// ```
import Foundation

/// @MainActor is used to ensure thread safety under Swift 6 concurrency checks.
@MainActor
final class DependencyInjector {

    static let shared = DependencyInjector()

    private var dependencies: [ObjectIdentifier: Any] = [:]
    private init() {}

    func register<T>(_ dependency: T) {
        let key = ObjectIdentifier(T.self)
        dependencies[key] = dependency
    }

    func resolve<T>() -> T {
        let key = ObjectIdentifier(T.self)
        guard let dependency = dependencies[key] as? T else {
            fatalError("No dependency registered for type \(T.self). Make sure to register it before resolving.")
        }
        return dependency
    }

    func resolveOptional<T>() -> T? {
        let key = ObjectIdentifier(T.self)
        return dependencies[key] as? T
    }
}
