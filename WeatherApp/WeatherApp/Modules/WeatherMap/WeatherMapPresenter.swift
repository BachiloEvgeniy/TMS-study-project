final class WeatherMapPresenter: WeatherMapPresenterProtocol {

    private weak var view: WeatherMapViewProtocol?

    init(view: WeatherMapViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        view?.displayMap(
            title: "Карта погоды",
            message: "Здесь появятся текущее местоположение и погодные маркеры городов."
        )
    }
}
