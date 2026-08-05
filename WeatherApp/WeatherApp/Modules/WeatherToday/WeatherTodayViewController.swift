import UIKit

final class WeatherTodayViewController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        configureLayout()
        showContent(
            title: "Погода сегодня",
            message: "Здесь появятся текущая погода, почасовой и пятидневный прогноз."
        )
    }

    private func configureView() {
        view.backgroundColor = .systemGroupedBackground
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
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
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

    @objc private func didTapSearch() {
        showContent(
            title: "Поиск города",
            message: "Экран поиска будет подключён на следующем этапе."
        )
    }

    @objc private func didTapRefresh() {
        showContent(
            title: "Обновление",
            message: "Источник погодных данных пока не подключён."
        )
    }
}
