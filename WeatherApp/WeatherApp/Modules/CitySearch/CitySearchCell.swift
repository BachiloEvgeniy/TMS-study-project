import UIKit

final class CitySearchCell: UITableViewCell {

    static let reuseIdentifier = "CitySearchCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModel: CitySearchViewModel) {
        textLabel?.text = viewModel.name
        detailTextLabel?.text = viewModel.details
    }

    private func configureView() {
        accessoryType = .disclosureIndicator
    }
}
