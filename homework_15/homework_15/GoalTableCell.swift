import UIKit
import SnapKit


final class GoalTableCell: UITableViewCell {
    
    static let identifier: String = "GoalTableCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = .systemGray3
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(goal: Goal){
        titleLabel.text = goal.title
        progressLabel.text = "\(goal.progress)%"
    }
}

private extension GoalTableCell {
    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(chevronImageView)
        
        chevronImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.lessThanOrEqualTo(chevronImageView.snp.leading).offset(-12)
        }

        progressLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
            $0.trailing.lessThanOrEqualTo(chevronImageView.snp.leading).offset(-12)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
    
}
