//
//  ViewController.swift
//  homework_8
//
//  Created by Evgeniy Bachilo on 08.05.2026.
//

import UIKit

class ViewController: UIViewController {
    private let imageView = UIImageView()
    private let label = UILabel()
    private let labelUsername = UILabel()
    private let usernameTextField = UITextField()
    private let labelPassword = UILabel()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let registerButton = UIButton()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "background1")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
    
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

        label.text = "My home control"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
        
        labelUsername.text = "Username"
        labelUsername.textColor = .white
        labelUsername.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        labelUsername.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelUsername)
        labelUsername.translatesAutoresizingMaskIntoConstraints = false
        labelUsername.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 100).isActive = true
        labelUsername.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        labelUsername.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        
        
        usernameTextField.placeholder = "Plese enter username"
        usernameTextField.backgroundColor = .white
        usernameTextField.layer.cornerRadius = 4
        usernameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        usernameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        usernameTextField.leftViewMode = .always
        usernameTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        usernameTextField.rightViewMode = .always
     
        self.view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.topAnchor.constraint(equalTo: labelUsername.bottomAnchor, constant: 8).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        
        
        // Password label
        
        labelPassword.text = "Password"
        labelPassword.textColor = .white
        labelPassword.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.addSubview(labelPassword)
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        labelPassword.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30).isActive = true
        labelPassword.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        labelPassword.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        
        // passwor input
        
        passwordTextField.placeholder = "Please enter password"
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 4
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        passwordTextField.leftViewMode = .always
        passwordTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        usernameTextField.rightViewMode = .always
     
        self.view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: labelPassword.bottomAnchor, constant: 8).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        
        // loginButton
        
        loginButton.setTitle("Log In", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 100).isActive = true
        loginButton.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive = true
        loginButton.backgroundColor = .lightGray
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 24,
            bottom: 8,
            trailing: 24
        )
        config.baseBackgroundColor = .lightGray
        config.background.cornerRadius = 0
        loginButton.configuration = config
        
        
        loginButton.addAction(UIAction { _ in
            let homeVC = HomeViewController()
            self.navigationController?.pushViewController(homeVC, animated: true)
        }, for: .touchUpInside)
        
        // registerButton
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150).isActive = true
        registerButton.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive = true
        
        registerButton.addAction(UIAction { _ in
            let registerVC = RegisterViewController()
            registerVC.modalPresentationStyle = .pageSheet
            self.present(registerVC, animated: true)
        }, for: .touchUpInside)
        
    }

}

