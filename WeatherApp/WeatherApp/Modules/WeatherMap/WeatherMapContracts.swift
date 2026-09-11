protocol WeatherMapViewProtocol: AnyObject {
    func displayMap(title: String, message: String)
}

protocol WeatherMapPresenterProtocol: AnyObject {
    func viewDidLoad()
}
