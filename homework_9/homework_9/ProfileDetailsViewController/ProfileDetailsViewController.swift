//
//  ProfileDetailsViewController.swift
//  homework_9
//
//  Created by Evgeniy Bachilo on 14.05.2026.
//

import UIKit

class ProfileDetailsViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Go Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.addAction(UIAction { _ in self.dismiss(animated: true)}, for: .touchUpInside)
        
    }
}
