import Foundation

protocol WeatherTodayViewProtocol: AnyObject {
    func displayWeather(_ viewModel: WeatherTodayViewModel)
    func displayError(title: String, message: String)
    func setLoading(_ isLoading: Bool)
    func showCitySearch(delegate: CitySearchDelegate)
    func openSource(_ url: URL)
}

protocol WeatherTodayPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapSearch()
    func didTapRefresh()
    func didTapSource()
}

struct WeatherTodayViewModel {
    let city: String
    let date: String
    let temperature: String
    let description: String
    let feelsLike: String
    let weatherIconName: String
    let metrics: [WeatherMetricViewModel]
    let hourlyForecast: [HourlyForecastViewModel]
    let dailyForecast: [DailyForecastViewModel]
}

struct WeatherMetricViewModel {
    let title: String
    let value: String
    let iconName: String
}

struct HourlyForecastViewModel {
    let time: String
    let temperature: String
    let iconName: String
}

struct DailyForecastViewModel {
    let day: String
    let date: String
    let maximumTemperature: String
    let minimumTemperature: String
    let iconName: String
}
