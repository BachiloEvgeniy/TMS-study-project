//
//  SecondViewController.swift
//  homework_12
//
//  Created by Evgeniy Bachilo on 25.05.2026.
//


import UIKit

class ForthViewController: UIViewController {
        
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Go BACK!", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    var callback: (String) -> Void
    
    init(callback: @escaping (String) -> Void) {
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        [textField,errorLabel, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20).isActive = true
        
        button.addAction(UIAction { [weak self] _ in
            guard let text = self?.textField.text, !text.isEmpty else {
                self?.errorLabel.text = "Please, enter text"
                return
            }
            self?.callback(text)
            self?.dismiss(animated: true)
        }, for: .touchUpInside)
    }
}


