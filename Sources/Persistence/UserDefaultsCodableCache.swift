import Foundation

protocol CodableCacheProtocol {
    func set<T: Codable>(_ object: T, forKey key: String)
    func get<T: Codable>(_ key: String, as type: T.Type) -> T?
    func remove(_ key: String)
}

final class UserDefaultsCodableCache: CodableCacheProtocol {
    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(
        userDefaults: UserDefaults = .standard,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
    }

    func set<T: Codable>(_ object: T, forKey key: String) {
        do {
            let data = try encoder.encode(object)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Encoding error for key \(key): \(error)")
        }
    }

    func get<T: Codable>(_ key: String, as type: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error for key \(key): \(error)")
            return nil
        }
    }

    func remove(_ key: String) {
        userDefaults.removeObject(forKey: key)
    }
}