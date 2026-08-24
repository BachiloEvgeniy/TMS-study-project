import UIKit

final class WeatherTodayViewController: UIViewController {

    private let weatherService = WeatherService()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    private let sourceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Данные: Open-Meteo", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .footnote)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        configureLayout()
        loadWeather()
    }

    private func configureView() {
        view.backgroundColor = .systemGroupedBackground
        sourceButton.addTarget(
            self,
            action: #selector(didTapSource),
            for: .touchUpInside
        )
    }

    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(didTapSearch)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(didTapRefresh)
        )
    }

    private func configureLayout() {
        let stackView = UIStackView(
            arrangedSubviews: [activityIndicator, titleLabel, messageLabel, sourceButton]
        )
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func showContent(title: String, message: String) {
        self.title = "Погода"
        titleLabel.text = title
        messageLabel.text = message
    }

    private func loadWeather() {
        setLoading(true)
        showContent(title: "Минск", message: "Загружаем погоду…")

        Task { [weak self] in
            guard let self else { return }
            defer { setLoading(false) }

            do {
                let weather = try await weatherService.fetchCurrentWeather(
                    city: "Минск",
                    latitude: 53.9,
                    longitude: 27.5667
                )
                let temperature = weather.temperature.formatted(
                    .number.precision(.fractionLength(0))
                )
                showContent(
                    title: weather.city,
                    message: "\(temperature) °C\n\(weather.description)"
                )
            } catch {
                showContent(
                    title: "Не удалось загрузить погоду",
                    message: "Проверьте подключение к интернету и попробуйте ещё раз.\n\(error.localizedDescription)"
                )
            }
        }
    }

    private func setLoading(_ isLoading: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = !isLoading

        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    @objc private func didTapSearch() {
        showContent(
            title: "Поиск города",
            message: "Экран поиска будет подключён на следующем этапе."
        )
    }

    @objc private func didTapRefresh() {
        loadWeather()
    }

    @objc private func didTapSource() {
        guard let url = URL(string: "https://open-meteo.com/") else { return }
        UIApplication.shared.open(url)
    }
}
