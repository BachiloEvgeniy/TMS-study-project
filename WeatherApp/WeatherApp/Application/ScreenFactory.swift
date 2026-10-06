import UIKit

final class ScreenFactory {

    private let weatherService: WeatherServiceProtocol
    private let cityStorageService: CityStorageServiceProtocol
    private let citySearchService: CitySearchServiceProtocol

    init(
        weatherService: WeatherServiceProtocol,
        cityStorageService: CityStorageServiceProtocol,
        citySearchService: CitySearchServiceProtocol
    ) {
        self.weatherService = weatherService
        self.cityStorageService = cityStorageService
        self.citySearchService = citySearchService
    }

    func makeWeatherTodayScreen() -> UIViewController {
        let viewController = WeatherTodayViewController(screenFactory: self)
        let presenter = WeatherTodayPresenter(
            view: viewController,
            weatherService: weatherService,
            cityStorageService: cityStorageService
        )
        viewController.presenter = presenter
        return viewController
    }

    func makeWeatherMapScreen() -> UIViewController {
        let viewController = WeatherMapViewController()
        let presenter = WeatherMapPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }

    func makeCitySearchScreen(delegate: CitySearchDelegate) -> UIViewController {
        let viewController = CitySearchViewController()
        let presenter = CitySearchPresenter(
            view: viewController,
            citySearchService: citySearchService,
            delegate: delegate
        )
        viewController.presenter = presenter
        return viewController
    }

    func makeDayDetailsScreen(
        weather: Weather,
        selectedDayIndex: Int
    ) -> UIViewController {
        let viewController = DayDetailsViewController()
        let presenter = DayDetailsPresenter(
            view: viewController,
            weather: weather,
            selectedDayIndex: selectedDayIndex
        )
        viewController.presenter = presenter
        return viewController
    }
}
