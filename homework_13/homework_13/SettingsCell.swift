
import UIKit

class SettingsCell: UITableViewCell {
    
    static let identifier = "SettingsCell"
    
        private let iconContainer = UIView()
        private let iconImageView = UIImageView()
        private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            backgroundColor = .darkGray
            selectionStyle = .none
            let chevron = UIImageView(image: UIImage(systemName: "chevron.right"))
            chevron.tintColor = .white
            chevron.contentMode = .scaleAspectFit
            chevron.frame = CGRect(x: 0, y: 0, width: 12, height: 20)
            accessoryView = chevron
            setupUI()
    }
    
    private func setupUI() {
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.layer.cornerRadius = 8
        iconContainer.clipsToBounds = true
        iconContainer.backgroundColor = .gray
        iconContainer.layer.borderColor = UIColor.lightGray.cgColor
        iconContainer.layer.borderWidth = 1
        
        iconImageView.contentMode = .scaleAspectFit
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 2
        
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        iconContainer.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconContainer.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: SettingsItem) {
                titleLabel.text = item.title
                iconImageView.image = UIImage(systemName: item.icon)
                iconImageView.tintColor = item.color
    }
}
