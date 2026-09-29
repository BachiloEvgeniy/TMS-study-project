struct Weather {
    let city: String
    let timezone: String
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct CurrentWeather {
    let time: String
    let temperature: Double
    let apparentTemperature: Double
    let humidity: Int
    let weatherCode: Int
    let surfacePressure: Double
    let windSpeed: Double
    let uvIndex: Double
    let isDay: Bool
}

struct HourlyWeather {
    let time: String
    let temperature: Double
    let weatherCode: Int
    let precipitationProbability: Int
    let visibility: Double
    let isDay: Bool
}

struct DailyWeather {
    let date: String
    let weatherCode: Int
    let maximumTemperature: Double
    let minimumTemperature: Double
    let sunrise: String
    let sunset: String
    let precipitationProbability: Int
    let uvIndex: Double
}
