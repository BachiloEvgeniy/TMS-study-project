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
