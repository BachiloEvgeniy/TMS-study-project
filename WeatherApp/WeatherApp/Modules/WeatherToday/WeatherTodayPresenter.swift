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
                view?.displayError(
                    title: "Не удалось загрузить погоду",
                    message: "Проверьте подключение к интернету и попробуйте ещё раз.\n\(error.localizedDescription)"
                )
            }
        }
    }

    private func makeViewModel(from weather: Weather) -> WeatherTodayViewModel {
        let current = weather.current
        let condition = makeCondition(
            weatherCode: current.weatherCode,
            isDay: current.isDay
        )
        let pressure = Int((current.surfacePressure * 0.750062).rounded())

        let metrics = [
            WeatherMetricViewModel(
                title: "Влажность",
                value: "\(current.humidity)%",
                iconName: "humidity.fill"
            ),
            WeatherMetricViewModel(
                title: "Ветер",
                value: "\(formatDecimal(current.windSpeed)) м/с",
                iconName: "wind"
            ),
            WeatherMetricViewModel(
                title: "Давление",
                value: "\(pressure) мм",
                iconName: "gauge.with.dots.needle.33percent"
            ),
            WeatherMetricViewModel(
                title: "UV-индекс",
                value: formatDecimal(current.uvIndex),
                iconName: "sun.max.fill"
            )
        ]

        return WeatherTodayViewModel(
            city: weather.city,
            date: formatDate(
                current.time,
                inputFormat: "yyyy-MM-dd'T'HH:mm",
                outputFormat: "EEEE, d MMMM",
                timezone: weather.timezone
            ),
            temperature: formatTemperature(current.temperature),
            description: condition.description,
            feelsLike: "Ощущается как \(formatTemperature(current.apparentTemperature))",
            weatherIconName: condition.iconName,
            metrics: metrics,
            hourlyForecast: makeHourlyForecast(from: weather),
            dailyForecast: makeDailyForecast(from: weather)
        )
    }

    private func makeHourlyForecast(from weather: Weather) -> [HourlyForecastViewModel] {
        weather.hourly.enumerated().map { index, hourlyWeather in
            let time: String

            if index == 0 {
                time = "Сейчас"
            } else {
                time = formatDate(
                    hourlyWeather.time,
                    inputFormat: "yyyy-MM-dd'T'HH:mm",
                    outputFormat: "HH:mm",
                    timezone: weather.timezone
                )
            }

            return HourlyForecastViewModel(
                time: time,
                temperature: formatTemperature(hourlyWeather.temperature),
                iconName: makeCondition(
                    weatherCode: hourlyWeather.weatherCode,
                    isDay: hourlyWeather.isDay
                ).iconName
            )
        }
    }

    private func makeDailyForecast(from weather: Weather) -> [DailyForecastViewModel] {
        weather.daily.enumerated().map { index, dailyWeather in
            let day = index == 0
                ? "Сегодня"
                : formatDate(
                    dailyWeather.date,
                    inputFormat: "yyyy-MM-dd",
                    outputFormat: "EEEE",
                    timezone: weather.timezone
                )

            return DailyForecastViewModel(
                day: day,
                date: formatDate(
                    dailyWeather.date,
                    inputFormat: "yyyy-MM-dd",
                    outputFormat: "d MMM",
                    timezone: weather.timezone
                ),
                maximumTemperature: formatTemperature(dailyWeather.maximumTemperature),
                minimumTemperature: formatTemperature(dailyWeather.minimumTemperature),
                iconName: makeCondition(
                    weatherCode: dailyWeather.weatherCode,
                    isDay: true
                ).iconName
            )
        }
    }

    private func makeCondition(
        weatherCode: Int,
        isDay: Bool
    ) -> (description: String, iconName: String) {
        switch weatherCode {
        case 0:
            return ("Ясно", isDay ? "sun.max.fill" : "moon.stars.fill")
        case 1:
            return ("Преимущественно ясно", isDay ? "sun.max.fill" : "moon.stars.fill")
        case 2:
            return ("Переменная облачность", isDay ? "cloud.sun.fill" : "cloud.moon.fill")
        case 3:
            return ("Пасмурно", "cloud.fill")
        case 45, 48:
            return ("Туман", "cloud.fog.fill")
        case 51, 53, 55, 56, 57:
            return ("Морось", "cloud.drizzle.fill")
        case 61, 63, 65, 66, 67:
            return ("Дождь", "cloud.rain.fill")
        case 71, 73, 75, 77:
            return ("Снег", "snowflake")
        case 80, 81, 82:
            return ("Ливень", "cloud.heavyrain.fill")
        case 85, 86:
            return ("Снегопад", "cloud.snow.fill")
        case 95, 96, 99:
            return ("Гроза", "cloud.bolt.rain.fill")
        default:
            return ("Неизвестные погодные условия", "questionmark.circle")
        }
    }

    private func formatTemperature(_ value: Double) -> String {
        "\(Int(value.rounded()))°"
    }

    private func formatDecimal(_ value: Double) -> String {
        value.formatted(
            .number
                .locale(Locale(identifier: "ru_RU"))
                .precision(.fractionLength(1))
        )
    }

    private func formatDate(
        _ value: String,
        inputFormat: String,
        outputFormat: String,
        timezone: String
    ) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(identifier: timezone)
        inputFormatter.dateFormat = inputFormat

        guard let date = inputFormatter.date(from: value) else {
            return value
        }

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ru_RU")
        outputFormatter.timeZone = TimeZone(identifier: timezone)
        outputFormatter.dateFormat = outputFormat

        return outputFormatter.string(from: date).capitalized
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
