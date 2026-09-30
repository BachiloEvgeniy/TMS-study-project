import Foundation

protocol CityStorageServiceProtocol: AnyObject {
    func saveCity(_ city: City)
    func loadCity() -> City?
}

final class CityStorageService: CityStorageServiceProtocol {

    private let cityKey = "selectedCity"
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func saveCity(_ city: City) {
        guard let data = try? JSONEncoder().encode(city) else { return }
        userDefaults.set(data, forKey: cityKey)
    }

    func loadCity() -> City? {
        guard let data = userDefaults.data(forKey: cityKey) else { return nil }
        return try? JSONDecoder().decode(City.self, from: data)
    }
}
