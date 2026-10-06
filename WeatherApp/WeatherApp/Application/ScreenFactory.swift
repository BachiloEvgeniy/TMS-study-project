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
        let presenter = WeatherTodayPresenter(
            weatherService: weatherService,
            cityStorageService: cityStorageService
        )
        let viewController = WeatherTodayViewController(
            presenter: presenter,
            screenFactory: self
        )
        presenter.view = viewController
        return viewController
    }

    func makeWeatherMapScreen() -> UIViewController {
        let presenter = WeatherMapPresenter()
        let viewController = WeatherMapViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeCitySearchScreen(delegate: CitySearchDelegate) -> UIViewController {
        let presenter = CitySearchPresenter(
            citySearchService: citySearchService,
            delegate: delegate
        )
        let viewController = CitySearchViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

    func makeDayDetailsScreen(
        weather: Weather,
        selectedDayIndex: Int
    ) -> UIViewController {
        let presenter = DayDetailsPresenter(
            weather: weather,
            selectedDayIndex: selectedDayIndex
        )
        let viewController = DayDetailsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }
}
