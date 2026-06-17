import UIKit
import SnapKit

final class AddGoalViewController: UIViewController {
    
    var onSave: ((Goal) -> Void)?
    
    private let titleTextField = UITextField()
    private let descriptionTextView = UITextView()
    private let saveButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title="Новая цель"
        setupUI()
    }
}

private extension AddGoalViewController {
    func setupUI() {
        titleTextField.placeholder = "Название цели"
        titleTextField.borderStyle = .roundedRect
                descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.systemGray4.cgColor
        descriptionTextView.layer.cornerRadius = 8
        descriptionTextView.font = .systemFont(ofSize: 16)
        
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .black
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 12,
            leading: 24,
            bottom: 12,
            trailing: 24
        )
        saveButton.configuration = config
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.layer.backgroundColor = UIColor.yellow.cgColor
        saveButton.layer.cornerRadius = 8
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.red.cgColor
        saveButton.addAction(UIAction { _n in
            self.onSavePress()
        }, for: .touchUpInside)
        
        cancelButton.configuration = config
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.layer.backgroundColor = UIColor.systemPink.cgColor
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.red.cgColor
        cancelButton.addAction(UIAction { _n in
            self.onCancelPress()
        }, for: .touchUpInside)
        
        
        
        
        
        
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextView)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(140)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
    }
    
    func onCancelPress() {
        dismiss(animated: true)
    }
    
    func onSavePress() {
        let title = titleTextField.text ?? ""
        
        guard !title.isEmpty else { return }
        let description = descriptionTextView.text ?? nil
        let progress = 0
        
        let goal = Goal(title: title, description: description, progress: progress)
        onSave?(goal)
        dismiss(animated: true)
    }
    
    
}
