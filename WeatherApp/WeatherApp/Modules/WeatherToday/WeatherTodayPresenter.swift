import Foundation

final class WeatherTodayPresenter: WeatherTodayPresenterProtocol {

    private weak var view: WeatherTodayViewProtocol?
    private let weatherService: WeatherServiceProtocol

    private var selectedCity = City(
        name: "Минск",
        country: "Беларусь",
        region: nil,
        latitude: 53.9,
        longitude: 27.5667
    )

    init(
        view: WeatherTodayViewProtocol,
        weatherService: WeatherServiceProtocol
    ) {
        self.view = view
        self.weatherService = weatherService
    }

    func viewDidLoad() {
        loadWeather()
    }

    func didTapSearch() {
        view?.showCitySearch(delegate: self)
    }

    func didTapRefresh() {
        loadWeather()
    }

    func didTapSource() {
        guard let url = URL(string: "https://open-meteo.com/") else { return }
        view?.openSource(url)
    }

    private func loadWeather() {
        let city = selectedCity
        let cityTitle = makeCityTitle(from: city)

        view?.setLoading(true)
        view?.displayWeather(
            WeatherTodayViewModel(
                title: cityTitle,
                message: "Загружаем погоду…"
            )
        )

        Task { [weak self] in
            guard let self else { return }
            defer { view?.setLoading(false) }

            do {
                let weather = try await weatherService.fetchCurrentWeather(
                    city: cityTitle,
                    latitude: city.latitude,
                    longitude: city.longitude
                )
                let viewModel = makeViewModel(from: weather)
                view?.displayWeather(viewModel)
            } catch {
                let viewModel = WeatherTodayViewModel(
                    title: "Не удалось загрузить погоду",
                    message: "Проверьте подключение к интернету и попробуйте ещё раз.\n\(error.localizedDescription)"
                )
                view?.displayWeather(viewModel)
            }
        }
    }

    private func makeViewModel(from weather: Weather) -> WeatherTodayViewModel {
        let temperature = weather.temperature.formatted(
            .number.precision(.fractionLength(0))
        )

        return WeatherTodayViewModel(
            title: weather.city,
            message: "\(temperature) °C\n\(weather.description)"
        )
    }

    private func makeCityTitle(from city: City) -> String {
        guard !city.country.isEmpty else { return city.name }
        return "\(city.name), \(city.country)"
    }
}

extension WeatherTodayPresenter: CitySearchDelegate {

    func didSelectCity(_ city: City) {
        selectedCity = city
        loadWeather()
    }
}
