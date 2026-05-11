//
//  RegisterViewController.swift
//  homework_8
//
//  Created by Evgeniy Bachilo on 11.05.2026.
//

import UIKit

class RegisterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background2")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
    
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        // title
        let titleLabel = UILabel()
        titleLabel.text = "Registration Form"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .white
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        //userName label
        let userNameLabel = UILabel()
        userNameLabel.text = "Username"
        userNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        userNameLabel.textColor = .white
        view.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        
        // username input
        let usernameInput = UITextField()
        usernameInput.placeholder = "Please enter username"
        usernameInput.borderStyle = .roundedRect
        view.addSubview(usernameInput)
        usernameInput.translatesAutoresizingMaskIntoConstraints = false
        usernameInput.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8).isActive = true
        usernameInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        usernameInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        
        
        //password label
        let passwordLabel = UILabel()
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        passwordLabel.textColor = .white
        view.addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.topAnchor.constraint(equalTo: usernameInput.bottomAnchor, constant: 30).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        passwordLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        
        // password input
        let passwordInput = UITextField()
        passwordInput.placeholder = "Please enter pasword"
        passwordInput.borderStyle = .roundedRect
        view.addSubview(passwordInput)
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8).isActive = true
        passwordInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        passwordInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        
        //confirm password label
        let confirmPasswordLabel = UILabel()
        confirmPasswordLabel.text = "Confirm password"
        confirmPasswordLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        confirmPasswordLabel.textColor = .white
        view.addSubview(confirmPasswordLabel)
        confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordLabel.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 30).isActive = true
        confirmPasswordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        confirmPasswordLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        
        // confirm password input
        let confirmPasswordInput = UITextField()
        confirmPasswordInput.placeholder = "Please confirm pasword"
        confirmPasswordInput.borderStyle = .roundedRect
        view.addSubview(confirmPasswordInput)
        confirmPasswordInput.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordInput.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 8).isActive = true
        confirmPasswordInput.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        confirmPasswordInput.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        
        // save button
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 24,
            bottom: 8,
            trailing: 24
        )
        config.baseBackgroundColor = .lightGray
        config.background.cornerRadius = 0
        saveButton.configuration = config
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: confirmPasswordInput.bottomAnchor, constant: 100).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        saveButton.addAction(UIAction { _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        
        
    }

}
