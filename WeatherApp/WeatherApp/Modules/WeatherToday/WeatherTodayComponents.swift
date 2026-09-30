import UIKit

final class WeatherMetricView: UIView {

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: 22,
            weight: .medium
        )
        return imageView
    }()

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: WeatherMetricViewModel) {
        iconImageView.image = UIImage(systemName: viewModel.iconName)
        valueLabel.text = viewModel.value
        titleLabel.text = viewModel.title
    }

    private func configureView() {
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 16
    }

    private func configureLayout() {
        let stackView = UIStackView(
            arrangedSubviews: [iconImageView, valueLabel, titleLabel]
        )
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            iconImageView.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
}

final class HourlyForecastCell: UICollectionViewCell {

    static let reuseIdentifier = "HourlyForecastCell"

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: 28,
            weight: .medium
        )
        return imageView
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: HourlyForecastViewModel) {
        timeLabel.text = viewModel.time
        iconImageView.image = UIImage(systemName: viewModel.iconName)
        temperatureLabel.text = viewModel.temperature
    }

    private func configureView() {
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 16
    }

    private func configureLayout() {
        let stackView = UIStackView(
            arrangedSubviews: [timeLabel, iconImageView, temperatureLabel]
        )
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            iconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}

final class DailyForecastRowView: UIControl {

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        return label
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: 24,
            weight: .medium
        )
        return imageView
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .right
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .tertiaryLabel
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: DailyForecastViewModel) {
        dayLabel.text = viewModel.day
        dateLabel.text = viewModel.date
        iconImageView.image = UIImage(systemName: viewModel.iconName)
        temperatureLabel.text = "\(viewModel.maximumTemperature)  \(viewModel.minimumTemperature)"
        accessibilityLabel = [
            viewModel.day,
            viewModel.date,
            "максимальная температура \(viewModel.maximumTemperature)",
            "минимальная температура \(viewModel.minimumTemperature)"
        ].joined(separator: ", ")
    }

    private func configureView() {
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 16
        isAccessibilityElement = true
        accessibilityTraits = .button
    }

    private func configureLayout() {
        let dateStackView = UIStackView(arrangedSubviews: [dayLabel, dateLabel])
        dateStackView.axis = .vertical
        dateStackView.spacing = 2

        let stackView = UIStackView(
            arrangedSubviews: [
                dateStackView,
                iconImageView,
                temperatureLabel,
                chevronImageView
            ]
        )
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.isUserInteractionEnabled = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 68),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            dateStackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 90),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 34),
            chevronImageView.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
}
