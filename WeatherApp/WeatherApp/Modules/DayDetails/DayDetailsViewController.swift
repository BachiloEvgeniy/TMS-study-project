import UIKit

final class DayDetailsViewController: UIViewController {

    var presenter: DayDetailsPresenterProtocol!

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

    private let chartTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Температура по часам"
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let temperatureChartView: TemperatureChartView = {
        let view = TemperatureChartView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let detailsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Подробные показатели"
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let metricViews = (0..<4).map { _ in DayDetailsMetricView() }

    private let metricsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureMetrics()
        configureLayout()
        presenter.viewDidLoad()
    }

    private func configureView() {
        title = "Прогноз на день"
        view.backgroundColor = .systemGroupedBackground
    }

    private func configureMetrics() {
        let firstRow = makeMetricRow(metricViews[0], metricViews[1])
        let secondRow = makeMetricRow(metricViews[2], metricViews[3])
        metricsStackView.addArrangedSubview(firstRow)
        metricsStackView.addArrangedSubview(secondRow)

        NSLayoutConstraint.activate([
            firstRow.heightAnchor.constraint(greaterThanOrEqualToConstant: 116),
            secondRow.heightAnchor.constraint(greaterThanOrEqualToConstant: 116)
        ])
    }

    private func makeMetricRow(_ firstView: UIView, _ secondView: UIView) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [firstView, secondView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }

    private func configureLayout() {
        let locationStackView = UIStackView(arrangedSubviews: [cityLabel, dateLabel])
        locationStackView.axis = .vertical
        locationStackView.spacing = 4

        [
            locationStackView,
            chartTitleLabel,
            temperatureChartView,
            detailsTitleLabel,
            metricsStackView
        ].forEach(contentStackView.addArrangedSubview)

        contentStackView.setCustomSpacing(24, after: locationStackView)
        contentStackView.setCustomSpacing(10, after: chartTitleLabel)
        contentStackView.setCustomSpacing(24, after: temperatureChartView)
        contentStackView.setCustomSpacing(10, after: detailsTitleLabel)

        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)

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
            temperatureChartView.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
}

extension DayDetailsViewController: DayDetailsViewProtocol {

    func displayDayDetails(_ viewModel: DayDetailsViewModel) {
        cityLabel.text = viewModel.city
        dateLabel.text = viewModel.date
        temperatureChartView.configure(with: viewModel.temperaturePoints)

        zip(metricViews, viewModel.metrics).forEach { metricView, viewModel in
            metricView.configure(with: viewModel)
        }
    }
}
