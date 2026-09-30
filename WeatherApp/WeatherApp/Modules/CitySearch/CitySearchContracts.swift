protocol CitySearchViewProtocol: AnyObject {
    func displayCities(_ viewModels: [CitySearchViewModel])
    func displayMessage(_ message: String?)
    func setLoading(_ isLoading: Bool)
    func close()
}

protocol CitySearchPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSubmitSearch(_ query: String)
    func didSelectCity(at index: Int)
    func didTapCancel()
}

protocol CitySearchDelegate: AnyObject {
    func didSelectCity(_ city: City)
}

struct CitySearchViewModel {
    let name: String
    let details: String
}
