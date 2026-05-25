//
//  FinalResultViewController.swift
//  homework_10
//
//  Created by Evgeniy Bachilo on 19.05.2026.
//

import UIKit

class FinalResultViewController: UIViewController {
    
    private let score: Int
    private let total: Int
    
    init(score: Int, total: Int) {
        self.score = score
        self.total = total
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let totalScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        totalScoreLabel.text =  """
        Викторина окончена!
        Ваш результат: \(score) из \(total)
        """
        view.addSubview(totalScoreLabel)
        totalScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        totalScoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        totalScoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    
    
}
