import Foundation

protocol CitySearchServiceProtocol: AnyObject {
    func searchCities(query: String) async throws -> [City]
}

final class CitySearchService: CitySearchServiceProtocol {

    func searchCities(query: String) async throws -> [City] {
        var components = URLComponents(
            string: "https://geocoding-api.open-meteo.com/v1/search"
        )
        components?.queryItems = [
            URLQueryItem(name: "name", value: query),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "language", value: "ru"),
            URLQueryItem(name: "format", value: "json")
        ]

        guard let url = components?.url else {
            throw CitySearchServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw CitySearchServiceError.invalidResponse
        }

        let responseModel = try JSONDecoder().decode(
            CitySearchResponse.self,
            from: data
        )

        return responseModel.results?.map { cityResponse in
            City(
                name: cityResponse.name,
                country: cityResponse.country ?? "",
                region: cityResponse.region,
                latitude: cityResponse.latitude,
                longitude: cityResponse.longitude
            )
        } ?? []
    }
}

private struct CitySearchResponse: Decodable {
    let results: [CityResponse]?
}

private struct CityResponse: Decodable {
    let name: String
    let country: String?
    let region: String?
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case name
        case country
        case region = "admin1"
        case latitude
        case longitude
    }
}

private enum CitySearchServiceError: LocalizedError {
    case invalidURL
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Не удалось создать адрес поиска."
        case .invalidResponse:
            return "Сервис поиска вернул некорректный ответ."
        }
    }
}
