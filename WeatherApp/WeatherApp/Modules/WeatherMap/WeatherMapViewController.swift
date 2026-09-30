import MapKit
import UIKit

final class WeatherMapViewController: UIViewController {

    var presenter: WeatherMapPresenterProtocol!

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.9)
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        presenter.viewDidLoad()
    }

    private func configureLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        view.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            messageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 56)
        ])
    }
}

extension WeatherMapViewController: WeatherMapViewProtocol {

    func displayMap(title: String, message: String) {
        self.title = title
        messageLabel.text = message
    }
}
