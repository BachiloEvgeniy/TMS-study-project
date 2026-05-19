//
//  AnswerResulViewController.swift
//  homework_10
//
//  Created by Evgeniy Bachilo on 15.05.2026.
//

import UIKit

class AnswerResultViewController: UIViewController {
    
    private let isCorrect: Bool
    private let answer: String
    
    init(isCorrect: Bool, answer: String) {
        self.isCorrect = isCorrect
        self.answer = answer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = isCorrect ? .green : .red
        resultLabel.text = isCorrect ? "Правильно!" : "Неверно!"
        answerLabel.text = "Ваш ответ:\n\(answer)"
        
        view.addSubview(resultLabel)
        view.addSubview(answerLabel)
        view.addSubview(button)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 40).isActive = true
        answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        answerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 60).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        button.addAction(UIAction { _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        
    }
}

