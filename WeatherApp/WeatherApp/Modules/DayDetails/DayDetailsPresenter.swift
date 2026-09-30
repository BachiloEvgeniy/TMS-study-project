import Foundation

final class DayDetailsPresenter: DayDetailsPresenterProtocol {

    private weak var view: DayDetailsViewProtocol?
    private let weather: Weather
    private let selectedDayIndex: Int

    init(
        view: DayDetailsViewProtocol,
        weather: Weather,
        selectedDayIndex: Int
    ) {
        self.view = view
        self.weather = weather
        self.selectedDayIndex = selectedDayIndex
    }

    func viewDidLoad() {
        guard weather.daily.indices.contains(selectedDayIndex) else { return }

        let day = weather.daily[selectedDayIndex]
        let hourlyWeather = weather.hourly.filter {
            $0.time.hasPrefix(day.date)
        }

        let temperaturePoints = hourlyWeather.map {
            TemperatureChartPointViewModel(
                time: formatTime($0.time),
                temperature: $0.temperature
            )
        }

        let averageVisibility = average(
            hourlyWeather.map(\.visibility)
        ) / 1_000
        let averagePressure = average(
            hourlyWeather.map(\.surfacePressure)
        ) * 0.750062

        let metrics = [
            DayDetailsMetricViewModel(
                title: "Восход / закат",
                value: "\(formatTime(day.sunrise)) / \(formatTime(day.sunset))",
                iconName: "sunrise.fill"
            ),
            DayDetailsMetricViewModel(
                title: "Вероятность дождя",
                value: "\(day.precipitationProbability)%",
                iconName: "cloud.rain.fill"
            ),
            DayDetailsMetricViewModel(
                title: "Видимость",
                value: "\(formatDecimal(averageVisibility)) км",
                iconName: "eye.fill"
            ),
            DayDetailsMetricViewModel(
                title: "Давление",
                value: "\(Int(averagePressure.rounded())) мм",
                iconName: "gauge.with.dots.needle.33percent"
            )
        ]

        let viewModel = DayDetailsViewModel(
            city: weather.city,
            date: formatDate(day.date),
            temperaturePoints: temperaturePoints,
            metrics: metrics
        )
        view?.displayDayDetails(viewModel)
    }

    private func average(_ values: [Double]) -> Double {
        guard !values.isEmpty else { return 0 }
        return values.reduce(0, +) / Double(values.count)
    }

    private func formatDate(_ value: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(identifier: weather.timezone)
        inputFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = inputFormatter.date(from: value) else {
            return value
        }

        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ru_RU")
        outputFormatter.timeZone = TimeZone(identifier: weather.timezone)
        outputFormatter.dateFormat = "EEEE, d MMMM"
        return outputFormatter.string(from: date).capitalized
    }

    private func formatTime(_ value: String) -> String {
        guard let separatorIndex = value.firstIndex(of: "T") else {
            return value
        }

        let timeStartIndex = value.index(after: separatorIndex)
        return String(value[timeStartIndex...].prefix(5))
    }

    private func formatDecimal(_ value: Double) -> String {
        value.formatted(
            .number
                .locale(Locale(identifier: "ru_RU"))
                .precision(.fractionLength(1))
        )
    }
}
