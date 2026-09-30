import UIKit

final class TemperatureChartView: UIView {

    private var points: [TemperatureChartPointViewModel] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with points: [TemperatureChartPointViewModel]) {
        self.points = points
        accessibilityLabel = makeAccessibilityLabel()
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(),
              points.count > 1 else {
            return
        }

        let chartRect = rect.inset(
            by: UIEdgeInsets(top: 28, left: 28, bottom: 38, right: 20)
        )
        let temperatures = points.map(\.temperature)
        guard let minimumTemperature = temperatures.min(),
              let maximumTemperature = temperatures.max() else {
            return
        }

        drawGrid(in: chartRect, context: context)

        let temperatureRange = max(maximumTemperature - minimumTemperature, 1)
        let horizontalStep = chartRect.width / CGFloat(points.count - 1)
        let chartPoints = points.enumerated().map { index, point in
            let x = chartRect.minX + CGFloat(index) * horizontalStep
            let progress = (point.temperature - minimumTemperature) / temperatureRange
            let y = chartRect.maxY - CGFloat(progress) * chartRect.height
            return CGPoint(x: x, y: y)
        }

        let linePath = UIBezierPath()
        linePath.move(to: chartPoints[0])
        chartPoints.dropFirst().forEach(linePath.addLine)
        UIColor.systemBlue.setStroke()
        linePath.lineWidth = 3
        linePath.lineJoinStyle = .round
        linePath.lineCapStyle = .round
        linePath.stroke()

        UIColor.systemBlue.setFill()
        chartPoints.forEach { point in
            let dotRect = CGRect(
                x: point.x - 2.5,
                y: point.y - 2.5,
                width: 5,
                height: 5
            )
            UIBezierPath(ovalIn: dotRect).fill()
        }

        drawTemperatureLabels(
            minimum: minimumTemperature,
            maximum: maximumTemperature,
            in: chartRect
        )
        drawTimeLabels(in: chartRect, horizontalStep: horizontalStep)
    }

    private func configureView() {
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 20
        layer.masksToBounds = true
        isAccessibilityElement = true
    }

    private func drawGrid(in rect: CGRect, context: CGContext) {
        context.saveGState()
        context.setStrokeColor(UIColor.separator.cgColor)
        context.setLineWidth(0.5)

        for index in 0...2 {
            let y = rect.minY + CGFloat(index) * rect.height / 2
            context.move(to: CGPoint(x: rect.minX, y: y))
            context.addLine(to: CGPoint(x: rect.maxX, y: y))
        }

        context.strokePath()
        context.restoreGState()
    }

    private func drawTemperatureLabels(
        minimum: Double,
        maximum: Double,
        in rect: CGRect
    ) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .caption2),
            .foregroundColor: UIColor.secondaryLabel
        ]

        let maximumText = "\(Int(maximum.rounded()))°" as NSString
        maximumText.draw(
            at: CGPoint(x: rect.minX, y: 6),
            withAttributes: attributes
        )

        let minimumText = "\(Int(minimum.rounded()))°" as NSString
        let minimumSize = minimumText.size(withAttributes: attributes)
        minimumText.draw(
            at: CGPoint(x: rect.minX, y: rect.maxY - minimumSize.height),
            withAttributes: attributes
        )
    }

    private func drawTimeLabels(in rect: CGRect, horizontalStep: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .caption2),
            .foregroundColor: UIColor.secondaryLabel,
            .paragraphStyle: paragraphStyle
        ]
        let labelIndexes = timeLabelIndexes()

        labelIndexes.forEach { index in
            let x = rect.minX + CGFloat(index) * horizontalStep
            let labelRect = CGRect(
                x: x - 24,
                y: rect.maxY + 10,
                width: 48,
                height: 18
            )
            (points[index].time as NSString).draw(
                in: labelRect,
                withAttributes: attributes
            )
        }
    }

    private func timeLabelIndexes() -> [Int] {
        let lastIndex = points.count - 1
        let indexes = [
            0,
            lastIndex / 4,
            lastIndex / 2,
            lastIndex * 3 / 4,
            lastIndex
        ]
        return Array(Set(indexes)).sorted()
    }

    private func makeAccessibilityLabel() -> String {
        points.map {
            "\($0.time): \(Int($0.temperature.rounded())) градусов"
        }.joined(separator: ", ")
    }
}

final class DayDetailsMetricView: UIView {

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
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
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 2
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

    func configure(with viewModel: DayDetailsMetricViewModel) {
        iconImageView.image = UIImage(systemName: viewModel.iconName)
        valueLabel.text = viewModel.value
        titleLabel.text = viewModel.title
        accessibilityLabel = "\(viewModel.title): \(viewModel.value)"
    }

    private func configureView() {
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 16
        isAccessibilityElement = true
    }

    private func configureLayout() {
        let stackView = UIStackView(
            arrangedSubviews: [iconImageView, valueLabel, titleLabel]
        )
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            iconImageView.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
}
