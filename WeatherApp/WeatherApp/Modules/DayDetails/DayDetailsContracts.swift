protocol DayDetailsViewProtocol: AnyObject {
    func displayDayDetails(_ viewModel: DayDetailsViewModel)
}

protocol DayDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
}

struct DayDetailsViewModel {
    let city: String
    let date: String
    let temperaturePoints: [TemperatureChartPointViewModel]
    let metrics: [DayDetailsMetricViewModel]
}

struct TemperatureChartPointViewModel {
    let time: String
    let temperature: Double
}

struct DayDetailsMetricViewModel {
    let title: String
    let value: String
    let iconName: String
}
