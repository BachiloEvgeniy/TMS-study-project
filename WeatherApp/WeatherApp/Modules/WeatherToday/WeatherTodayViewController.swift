import UIKit

final class WeatherTodayViewController: UIViewController {

    var presenter: WeatherTodayPresenterProtocol!

    private var hourlyForecast: [HourlyForecastViewModel] = []
    private var hasWeatherData = false

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        return label
    }()

    private let currentWeatherCard: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 24
        return view
    }()

    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: 72,
            weight: .regular
        )
        return imageView
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 58, weight: .thin)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        return label
    }()

    private let metricViews = (0..<4).map { _ in WeatherMetricView() }

    private let metricsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private let hourlyTitleLabel = WeatherTodayViewController.makeSectionLabel(
        title: "Прогноз по часам"
    )

    private let hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 82, height: 120)
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let dailyTitleLabel = WeatherTodayViewController.makeSectionLabel(
        title: "Прогноз на 5 дней"
    )

    private let dailyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private let sourceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Данные: Open-Meteo", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .footnote)
        return button
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        configureCurrentWeatherCard()
        configureMetrics()
        configureLayout()
        presenter.viewDidLoad()
    }

    private func configureView() {
        title = "Погода"
        view.backgroundColor = .systemGroupedBackground
        scrollView.isHidden = true

        hourlyCollectionView.dataSource = self
        hourlyCollectionView.register(
            HourlyForecastCell.self,
            forCellWithReuseIdentifier: HourlyForecastCell.reuseIdentifier
        )

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

    private func configureCurrentWeatherCard() {
        let labelsStackView = UIStackView(
            arrangedSubviews: [temperatureLabel, descriptionLabel, feelsLikeLabel]
        )
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4

        let currentWeatherStackView = UIStackView(
            arrangedSubviews: [weatherIconImageView, labelsStackView]
        )
        currentWeatherStackView.axis = .horizontal
        currentWeatherStackView.alignment = .center
        currentWeatherStackView.spacing = 20
        currentWeatherStackView.translatesAutoresizingMaskIntoConstraints = false

        currentWeatherCard.addSubview(currentWeatherStackView)

        NSLayoutConstraint.activate([
            currentWeatherCard.heightAnchor.constraint(greaterThanOrEqualToConstant: 190),
            currentWeatherStackView.topAnchor.constraint(
                equalTo: currentWeatherCard.topAnchor,
                constant: 24
            ),
            currentWeatherStackView.leadingAnchor.constraint(
                equalTo: currentWeatherCard.leadingAnchor,
                constant: 20
            ),
            currentWeatherStackView.trailingAnchor.constraint(
                equalTo: currentWeatherCard.trailingAnchor,
                constant: -20
            ),
            currentWeatherStackView.bottomAnchor.constraint(
                equalTo: currentWeatherCard.bottomAnchor,
                constant: -24
            ),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 110),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func configureMetrics() {
        let firstRow = UIStackView(arrangedSubviews: [metricViews[0], metricViews[1]])
        firstRow.axis = .horizontal
        firstRow.distribution = .fillEqually
        firstRow.spacing = 12

        let secondRow = UIStackView(arrangedSubviews: [metricViews[2], metricViews[3]])
        secondRow.axis = .horizontal
        secondRow.distribution = .fillEqually
        secondRow.spacing = 12

        metricsStackView.addArrangedSubview(firstRow)
        metricsStackView.addArrangedSubview(secondRow)

        NSLayoutConstraint.activate([
            firstRow.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            secondRow.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }

    private func configureLayout() {
        let locationStackView = UIStackView(arrangedSubviews: [cityLabel, dateLabel])
        locationStackView.axis = .vertical
        locationStackView.spacing = 4

        [
            locationStackView,
            currentWeatherCard,
            metricsStackView,
            hourlyTitleLabel,
            hourlyCollectionView,
            dailyTitleLabel,
            dailyStackView,
            sourceButton
        ].forEach(contentStackView.addArrangedSubview)

        contentStackView.setCustomSpacing(24, after: metricsStackView)
        contentStackView.setCustomSpacing(10, after: hourlyTitleLabel)
        contentStackView.setCustomSpacing(24, after: hourlyCollectionView)
        contentStackView.setCustomSpacing(10, after: dailyTitleLabel)
        contentStackView.setCustomSpacing(24, after: dailyStackView)

        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentStackView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 16
            ),
            contentStackView.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 16
            ),
            contentStackView.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor,
                constant: -16
            ),
            contentStackView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -24
            ),
            contentStackView.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -32
            ),

            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 120),

            errorLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            errorLabel.leadingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.leadingAnchor,
                constant: 16
            ),
            errorLabel.trailingAnchor.constraint(
                equalTo: view.layoutMarginsGuide.trailingAnchor,
                constant: -16
            ),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func updateDailyForecast(_ forecast: [DailyForecastViewModel]) {
        dailyStackView.arrangedSubviews.forEach { view in
            dailyStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        forecast.forEach { viewModel in
            let rowView = DailyForecastRowView()
            rowView.configure(with: viewModel)
            dailyStackView.addArrangedSubview(rowView)
        }
    }

    private static func makeSectionLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }

    @objc private func didTapSearch() {
        presenter.didTapSearch()
    }

    @objc private func didTapRefresh() {
        presenter.didTapRefresh()
    }

    @objc private func didTapSource() {
        presenter.didTapSource()
    }
}

extension WeatherTodayViewController: WeatherTodayViewProtocol {

    func displayWeather(_ viewModel: WeatherTodayViewModel) {
        hasWeatherData = true
        scrollView.isHidden = false
        errorLabel.isHidden = true

        cityLabel.text = viewModel.city
        dateLabel.text = viewModel.date
        temperatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.description
        feelsLikeLabel.text = viewModel.feelsLike
        weatherIconImageView.image = UIImage(systemName: viewModel.weatherIconName)

        zip(metricViews, viewModel.metrics).forEach { metricView, metricViewModel in
            metricView.configure(with: metricViewModel)
        }

        hourlyForecast = viewModel.hourlyForecast
        hourlyCollectionView.reloadData()
        updateDailyForecast(viewModel.dailyForecast)
    }

    func displayError(title: String, message: String) {
        if hasWeatherData {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "ОК", style: .default))
            present(alert, animated: true)
        } else {
            scrollView.isHidden = true
            errorLabel.text = "\(title)\n\n\(message)"
            errorLabel.isHidden = false
        }
    }

    func setLoading(_ isLoading: Bool) {
        navigationItem.leftBarButtonItem?.isEnabled = !isLoading
        navigationItem.rightBarButtonItem?.isEnabled = !isLoading

        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func showCitySearch(delegate: CitySearchDelegate) {
        let citySearchViewController = CitySearchViewController()
        let citySearchPresenter = CitySearchPresenter(
            view: citySearchViewController,
            citySearchService: CitySearchService(),
            delegate: delegate
        )
        citySearchViewController.presenter = citySearchPresenter

        let navigationController = UINavigationController(
            rootViewController: citySearchViewController
        )
        present(navigationController, animated: true)
    }

    func openSource(_ url: URL) {
        UIApplication.shared.open(url)
    }
}

extension WeatherTodayViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        hourlyForecast.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HourlyForecastCell.reuseIdentifier,
            for: indexPath
        ) as? HourlyForecastCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: hourlyForecast[indexPath.item])
        return cell
    }
}
