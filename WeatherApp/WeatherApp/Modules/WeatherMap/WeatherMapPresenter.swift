protocol WeatherMapPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class WeatherMapPresenter: WeatherMapPresenterProtocol {

    weak var view: WeatherMapViewProtocol?

    func viewDidLoad() {
        view?.displayMap(
            title: "Карта погоды",
            message: "Здесь появятся текущее местоположение и погодные маркеры городов."
        )
    }
}
