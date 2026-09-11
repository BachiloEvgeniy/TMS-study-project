import Foundation

protocol WeatherTodayViewProtocol: AnyObject {
    func displayWeather(_ viewModel: WeatherTodayViewModel)
    func setLoading(_ isLoading: Bool)
    func openSource(_ url: URL)
}

protocol WeatherTodayPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapSearch()
    func didTapRefresh()
    func didTapSource()
}

struct WeatherTodayViewModel {
    let title: String
    let message: String
}
