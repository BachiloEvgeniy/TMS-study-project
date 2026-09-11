import UIKit

final class WeatherTodayViewController: UIViewController {

    var presenter: WeatherTodayPresenterProtocol!

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
        presenter.viewDidLoad()
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
        title = "Погода"
        titleLabel.text = viewModel.title
        messageLabel.text = viewModel.message
    }

    func setLoading(_ isLoading: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = !isLoading

        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func openSource(_ url: URL) {
        UIApplication.shared.open(url)
    }
}
