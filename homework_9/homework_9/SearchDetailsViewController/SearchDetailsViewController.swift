//
//  SearchDetailsViewController.swift
//  homework_9
//
//  Created by Evgeniy Bachilo on 14.05.2026.
//

import UIKit

class SearchDetailsViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Go back", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        title = "Search Details"
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.addAction(UIAction {_ in
            self.navigationController?.popViewController(animated: true)}, for: .touchUpInside)
    }
    

}
