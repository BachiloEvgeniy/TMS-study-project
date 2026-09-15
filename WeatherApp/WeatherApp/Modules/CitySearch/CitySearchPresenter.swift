import Foundation

final class CitySearchPresenter: CitySearchPresenterProtocol {

    private weak var view: CitySearchViewProtocol?
    private weak var delegate: CitySearchDelegate?
    private let citySearchService: CitySearchServiceProtocol

    private var cities: [City] = []
    private var isSearching = false

    init(
        view: CitySearchViewProtocol,
        citySearchService: CitySearchServiceProtocol,
        delegate: CitySearchDelegate
    ) {
        self.view = view
        self.citySearchService = citySearchService
        self.delegate = delegate
    }

    func viewDidLoad() {
        view?.displayMessage(
            "Введите минимум два символа и нажмите «Найти» на клавиатуре."
        )
    }

    func didSubmitSearch(_ query: String) {
        let preparedQuery = query.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard preparedQuery.count >= 2 else {
            view?.displayCities([])
            view?.displayMessage("Введите минимум два символа.")
            return
        }

        guard !isSearching else { return }

        isSearching = true
        view?.displayCities([])
        view?.displayMessage(nil)
        view?.setLoading(true)

        Task { [weak self] in
            guard let self else { return }
            defer {
                isSearching = false
                view?.setLoading(false)
            }

            do {
                cities = try await citySearchService.searchCities(
                    query: preparedQuery
                )

                let viewModels = cities.map(makeViewModel)
                view?.displayCities(viewModels)

                if cities.isEmpty {
                    view?.displayMessage("Города не найдены.")
                }
            } catch {
                cities = []
                view?.displayCities([])
                view?.displayMessage(
                    "Не удалось выполнить поиск.\n\(error.localizedDescription)"
                )
            }
        }
    }

    func didSelectCity(at index: Int) {
        guard cities.indices.contains(index) else { return }

        delegate?.didSelectCity(cities[index])
        view?.close()
    }

    func didTapCancel() {
        view?.close()
    }

    private func makeViewModel(from city: City) -> CitySearchViewModel {
        var details: [String] = []

        if let region = city.region,
           !region.isEmpty,
           region != city.country {
            details.append(region)
        }

        if !city.country.isEmpty {
            details.append(city.country)
        }

        return CitySearchViewModel(
            name: city.name,
            details: details.joined(separator: ", ")
        )
    }
}
