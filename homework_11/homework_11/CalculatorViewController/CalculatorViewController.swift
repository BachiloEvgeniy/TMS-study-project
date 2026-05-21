//
//  CalculatorViewController.swift
//  homework_11
//
//  Created by Evgeniy Bachilo on 21.05.2026.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private let displayLabel: UILabel = {
          let label = UILabel()
          label.text = "0"
          label.textColor = .white
          label.font = .systemFont(ofSize: 88, weight: .light)
          label.textAlignment = .right
          label.adjustsFontSizeToFitWidth = true
          return label
      }()
    
    private let buttons: [[(text: String, color: UIColor)]] = [
        [
            (text: "⌫", color: .gray),
            (text: "AC", color: .gray),
            (text: "%", color: .gray),
            (text: "÷", color: .orange)
        ],
        [
            (text: "7", color: .darkGray),
            (text: "8", color: .darkGray),
            (text: "9", color: .darkGray),
            (text: "×", color: .orange)
        ],
        [
            (text: "4", color: .darkGray),
            (text: "5", color: .darkGray),
            (text: "6", color: .darkGray),
            (text: "−", color: .orange)
        ],
        [
            (text: "1", color: .darkGray),
            (text: "2", color: .darkGray),
            (text: "3", color: .darkGray),
            (text: "+", color: .orange)
        ],
        [
            (text: "+/-", color: .darkGray),
            (text: "0", color: .darkGray),
            (text: ",", color: .darkGray),
            (text: "=", color: .orange)
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupLayout()
    }
    
    
    private func setupLayout() {
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.distribution = .fill
 
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(displayLabel)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        
        
        for row in buttons {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 12
            rowStack.distribution = .fillEqually
            for buttonParams in row {
                let button = makeButton(buttonParams: buttonParams)
                rowStack.addArrangedSubview(button)
            }
            mainStack.addArrangedSubview(rowStack)
            rowStack.translatesAutoresizingMaskIntoConstraints = false
            rowStack.heightAnchor.constraint(equalToConstant: 80).isActive = true
        }
        


        }
    private func makeButton(buttonParams: (text: String, color: UIColor)) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(buttonParams.text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 38, weight: .regular)
        button.backgroundColor = buttonParams.color
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

