import Foundation

final class WeatherService {

    func fetchCurrentWeather(
        city: String,
        latitude: Double,
        longitude: Double
    ) async throws -> Weather {
        var components = URLComponents(string: "https://api.open-meteo.com/v1/forecast")
        components?.queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
            URLQueryItem(name: "current", value: "temperature_2m,weather_code"),
            URLQueryItem(name: "timezone", value: "auto")
        ]

        guard let url = components?.url else {
            throw WeatherServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw WeatherServiceError.invalidResponse
        }

        let responseModel = try JSONDecoder().decode(WeatherResponse.self, from: data)

        return Weather(
            city: city,
            temperature: responseModel.current.temperature,
            description: description(for: responseModel.current.weatherCode)
        )
    }

    private func description(for weatherCode: Int) -> String {
        switch weatherCode {
        case 0:
            return "Ясно"
        case 1:
            return "Преимущественно ясно"
        case 2:
            return "Переменная облачность"
        case 3:
            return "Пасмурно"
        case 45, 48:
            return "Туман"
        case 51, 53, 55, 56, 57:
            return "Морось"
        case 61, 63, 65, 66, 67:
            return "Дождь"
        case 71, 73, 75, 77:
            return "Снег"
        case 80, 81, 82:
            return "Ливень"
        case 85, 86:
            return "Снегопад"
        case 95, 96, 99:
            return "Гроза"
        default:
            return "Неизвестные погодные условия"
        }
    }
}

private struct WeatherResponse: Decodable {
    let current: CurrentWeather
}

private struct CurrentWeather: Decodable {
    let temperature: Double
    let weatherCode: Int

    enum CodingKeys: String, CodingKey {
        case temperature = "temperature_2m"
        case weatherCode = "weather_code"
    }
}

private enum WeatherServiceError: LocalizedError {
    case invalidURL
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Не удалось создать адрес запроса."
        case .invalidResponse:
            return "Сервер вернул некорректный ответ."
        }
    }
}
