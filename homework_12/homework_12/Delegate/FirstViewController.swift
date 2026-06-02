//
//  FirstViewController.swift
//  homework_12
//
//  Created by Evgeniy Bachilo on 25.05.2026.
//

import UIKit

class FirstViewController: UIViewController, SecondViewControllerDelegate {
    

    
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Go to second", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        [label, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        
        button.addAction(
            UIAction { [weak self] _ in
                let vc = SecondViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.delegate = self
                self?.present(vc, animated: true)
            },
            for: .touchUpInside
        )
    }
    
    func didTextEnter(_ text: String) {
        label.text = text
    }

}

