import Foundation

protocol WeatherServiceProtocol: AnyObject {
    func fetchCurrentWeather(
        city: String,
        latitude: Double,
        longitude: Double
    ) async throws -> Weather
}

final class WeatherService: WeatherServiceProtocol {

    func fetchCurrentWeather(
        city: String,
        latitude: Double,
        longitude: Double
    ) async throws -> Weather {
        var components = URLComponents(string: "https://api.open-meteo.com/v1/forecast")
        components?.queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
            URLQueryItem(
                name: "current",
                value: [
                    "temperature_2m",
                    "relative_humidity_2m",
                    "apparent_temperature",
                    "weather_code",
                    "surface_pressure",
                    "wind_speed_10m",
                    "is_day"
                ].joined(separator: ",")
            ),
            URLQueryItem(
                name: "hourly",
                value: [
                    "temperature_2m",
                    "weather_code",
                    "uv_index",
                    "precipitation_probability",
                    "visibility",
                    "surface_pressure",
                    "is_day"
                ].joined(separator: ",")
            ),
            URLQueryItem(
                name: "daily",
                value: [
                    "weather_code",
                    "temperature_2m_max",
                    "temperature_2m_min",
                    "sunrise",
                    "sunset",
                    "precipitation_probability_max",
                    "uv_index_max"
                ].joined(separator: ",")
            ),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "forecast_days", value: "5"),
            URLQueryItem(name: "wind_speed_unit", value: "ms")
        ]

        guard let url = components?.url else {
            throw WeatherServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw WeatherServiceError.invalidResponse
        }

        let responseModel: WeatherResponse

        do {
            responseModel = try JSONDecoder().decode(WeatherResponse.self, from: data)
        } catch {
            throw WeatherServiceError.decodingFailed
        }

        return makeWeather(city: city, response: responseModel)
    }

    private func makeWeather(city: String, response: WeatherResponse) -> Weather {
        let hourly = makeHourlyWeather(from: response.hourly)
        let daily = makeDailyWeather(from: response.daily)
        let currentHour = String(response.current.time.prefix(13))
        let currentHourIndex = response.hourly.time.firstIndex {
            $0.hasPrefix(currentHour)
        } ?? 0
        let currentUVIndex = response.hourly.uvIndex.indices.contains(currentHourIndex)
            ? response.hourly.uvIndex[currentHourIndex]
            : 0

        let current = CurrentWeather(
            time: response.current.time,
            temperature: response.current.temperature,
            apparentTemperature: response.current.apparentTemperature,
            humidity: response.current.humidity,
            weatherCode: response.current.weatherCode,
            surfacePressure: response.current.surfacePressure,
            windSpeed: response.current.windSpeed,
            uvIndex: currentUVIndex,
            isDay: response.current.isDay == 1
        )

        return Weather(
            city: city,
            timezone: response.timezone,
            current: current,
            hourly: hourly,
            daily: daily
        )
    }

    private func makeHourlyWeather(from response: HourlyWeatherResponse) -> [HourlyWeather] {
        let count = [
            response.time.count,
            response.temperature.count,
            response.weatherCode.count,
            response.precipitationProbability.count,
            response.visibility.count,
            response.surfacePressure.count,
            response.isDay.count
        ].min() ?? 0

        return (0..<count).map { index in
            HourlyWeather(
                time: response.time[index],
                temperature: response.temperature[index],
                weatherCode: response.weatherCode[index],
                precipitationProbability: response.precipitationProbability[index],
                visibility: response.visibility[index],
                surfacePressure: response.surfacePressure[index],
                isDay: response.isDay[index] == 1
            )
        }
    }

    private func makeDailyWeather(from response: DailyWeatherResponse) -> [DailyWeather] {
        let count = [
            response.time.count,
            response.weatherCode.count,
            response.maximumTemperature.count,
            response.minimumTemperature.count,
            response.sunrise.count,
            response.sunset.count,
            response.precipitationProbability.count,
            response.uvIndex.count
        ].min() ?? 0

        return (0..<count).map { index in
            DailyWeather(
                date: response.time[index],
                weatherCode: response.weatherCode[index],
                maximumTemperature: response.maximumTemperature[index],
                minimumTemperature: response.minimumTemperature[index],
                sunrise: response.sunrise[index],
                sunset: response.sunset[index],
                precipitationProbability: response.precipitationProbability[index],
                uvIndex: response.uvIndex[index]
            )
        }
    }
}

private struct WeatherResponse: Decodable {
    let timezone: String
    let current: CurrentWeatherResponse
    let hourly: HourlyWeatherResponse
    let daily: DailyWeatherResponse
}

private struct CurrentWeatherResponse: Decodable {
    let time: String
    let temperature: Double
    let apparentTemperature: Double
    let humidity: Int
    let weatherCode: Int
    let surfacePressure: Double
    let windSpeed: Double
    let isDay: Int

    enum CodingKeys: String, CodingKey {
        case time
        case temperature = "temperature_2m"
        case apparentTemperature = "apparent_temperature"
        case humidity = "relative_humidity_2m"
        case weatherCode = "weather_code"
        case surfacePressure = "surface_pressure"
        case windSpeed = "wind_speed_10m"
        case isDay = "is_day"
    }
}

private struct HourlyWeatherResponse: Decodable {
    let time: [String]
    let temperature: [Double]
    let weatherCode: [Int]
    let uvIndex: [Double]
    let precipitationProbability: [Int]
    let visibility: [Double]
    let surfacePressure: [Double]
    let isDay: [Int]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature = "temperature_2m"
        case weatherCode = "weather_code"
        case uvIndex = "uv_index"
        case precipitationProbability = "precipitation_probability"
        case visibility
        case surfacePressure = "surface_pressure"
        case isDay = "is_day"
    }
}

private struct DailyWeatherResponse: Decodable {
    let time: [String]
    let weatherCode: [Int]
    let maximumTemperature: [Double]
    let minimumTemperature: [Double]
    let sunrise: [String]
    let sunset: [String]
    let precipitationProbability: [Int]
    let uvIndex: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case maximumTemperature = "temperature_2m_max"
        case minimumTemperature = "temperature_2m_min"
        case sunrise
        case sunset
        case precipitationProbability = "precipitation_probability_max"
        case uvIndex = "uv_index_max"
    }
}

private enum WeatherServiceError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Не удалось создать адрес запроса."
        case .invalidResponse:
            return "Сервер вернул некорректный ответ."
        case .decodingFailed:
            return "Не удалось обработать данные о погоде."
        }
    }
}
