import UIKit
import SnapKit

final class GoalDetailsController: UIViewController {
    
    var onProgressChanged: ((Int) -> Void)?
    
    private var goal: Goal
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let progressLabel = UILabel()
    private let slider = UISlider()
    
    init(goal: Goal) {
        self.goal = goal
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Детали цели"
        setupUI()
        updateProgressLabel()
    }
    
    private func setupUI() {
        titleLabel.text = goal.title
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .blue
        if let description = goal.description, !description.isEmpty {
            descriptionLabel.text = "Описание: \(description)"
        } else {
            descriptionLabel.text = "Описание отсутствует"
        }
        descriptionLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.numberOfLines = 0
        progressLabel.text = "\(goal.progress)%"
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = Float(goal.progress)
        slider.addAction(UIAction { [weak self] _ in
            self?.sliderChanged()
        }, for: .valueChanged)
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(progressLabel)
        view.addSubview(slider)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        slider.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func sliderChanged() {
        goal.progress = Int(self.slider.value)
        updateProgressLabel()
        onProgressChanged?(goal.progress)
    }
    
    private func updateProgressLabel() {
        progressLabel.text = "Прогресс: \(goal.progress)%"
    }
}
