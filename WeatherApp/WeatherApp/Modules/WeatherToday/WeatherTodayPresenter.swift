import Foundation

final class WeatherTodayPresenter: WeatherTodayPresenterProtocol {

    private weak var view: WeatherTodayViewProtocol?
    private let weatherService: WeatherServiceProtocol

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
        let viewModel = WeatherTodayViewModel(
            title: "Поиск города",
            message: "Экран поиска будет подключён на следующем этапе."
        )
        view?.displayWeather(viewModel)
    }

    func didTapRefresh() {
        loadWeather()
    }

    func didTapSource() {
        guard let url = URL(string: "https://open-meteo.com/") else { return }
        view?.openSource(url)
    }

    private func loadWeather() {
        view?.setLoading(true)
        view?.displayWeather(
            WeatherTodayViewModel(
                title: "Минск",
                message: "Загружаем погоду…"
            )
        )

        Task { [weak self] in
            guard let self else { return }
            defer { view?.setLoading(false) }

            do {
                let weather = try await weatherService.fetchCurrentWeather(
                    city: "Минск",
                    latitude: 53.9,
                    longitude: 27.5667
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
}
