//
//  ViewController.swift
//  homework_10
//
//  Created by Evgeniy Bachilo on 14.05.2026.
//

import UIKit

struct Question {
    let title: String
    let subtitle: String?
    let answers: [String]
    let correctIndex: Int
}

class ViewController: UIViewController {
    
    private let questions: [Question] = [
        Question(
            title: "Что будет выведено в консоль?",
            subtitle: """
            var x = 5
            let y = x
            x = 10
            print(y)
            """,
            answers: ["10", "5", "Ошибка компиляции", "nil"],
            correctIndex: 1
        ),
        Question(
            title: "Как правильно объявить опциональную строку?",
            subtitle: nil,
            answers: ["var name: String", "var name: String?", "var name: Optional<String>", "var name = nil"],
            correctIndex: 1
        ),
        Question(
            title: "Какое значение будет у result?",
            subtitle: #"let result = "10" + "5""#,
            answers: ["15", #""105""#, "Ошибка компиляции", #""15""#],
            correctIndex: 1
        ),
        Question(
            title: "Что такое weak var?",
            subtitle: nil,
            answers: [
                "Переменная только для чтения",
                "Слабая ссылка, предотвращающая retain cycle",
                "Переменная с низким приоритетом",
                "Синоним для optional"
            ],
            correctIndex: 1
        ),
        Question(
            title: "Что делает этот код?",
            subtitle: "[1, 2, 3].map { $0 * 2 }",
            answers: [
                "Удваивает каждый элемент массива",
                "Создает массив из двух элементов",
                "Вызывает ошибку",
                "Ничего не делает"
            ],
            correctIndex: 0
        ),
        Question(
            title: "Какой метод вызывается перед появлением контроллера на экране?",
            subtitle: nil,
            answers: ["viewDidLoad()", "viewWillAppear()", "viewDidAppear()", "loadView()"],
            correctIndex: 1
        ),
        Question(
            title: "Какой способ НЕ подходит для возврата на предыдущий экран?",
            subtitle: nil,
            answers: [
                "navigationController?.popViewController(animated: true)",
                "dismiss(animated: true)",
                "navigationController?.pushViewController(animated: true)",
                "unwind segue"
            ],
            correctIndex: 2
        ),
        Question(
            title: "Что делает navigationController?.popViewController(animated: true)?",
            subtitle: nil,
            answers: [
                "Закрывает приложение",
                "Возвращает на предыдущий экран",
                "Добавляет новый контроллер в стек",
                "Перезагружает текущий контроллер"
            ],
            correctIndex: 1
        ),
        Question(
            title: "Какой метод вызывается только один раз за жизнь ViewController?",
            subtitle: nil,
            answers: ["viewWillAppear", "viewDidAppear", "viewDidLoad", "viewWillDisappear"],
            correctIndex: 2
        ),
        Question(
            title: "Что произойдет при вызове navigationController?.pushViewController(vc, animated: true), если навигационного контроллера нет?",
            subtitle: nil,
            answers: [
                "Приложение упадет",
                "Ничего не произойдет",
                "Откроется новый контроллер модально",
                "Вызовется ошибка компиляции"
            ],
            correctIndex: 1
        )
    ]
    
    private var currentQuestionIndex: Int = 0
    private var totalScore: Int = 0
    private var isFirstLaunch: Bool = true
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var answerButton1: UIButton = {
        let button = UIButton(type: .system)
        button.tag=0
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 18, weight: .medium)
            return outgoing
        }
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16)
        button.configuration = config
        return button
    }()
    
    private var answerButton2: UIButton = {
        let button = UIButton(type: .system)
        button.tag=1
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 18, weight: .medium)
            return outgoing
        }
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16)
        button.configuration = config
        return button
    }()
    
    private var answerButton3: UIButton = {
        let button = UIButton(type: .system)
        button.tag=2
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 18, weight: .medium)
            return outgoing
        }
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16)
        button.configuration = config
        return button
    }()
    
    private var answerButton4: UIButton = {
        let button = UIButton(type: .system)
        button.tag=3
        var config = UIButton.Configuration.filled()
        config.titleAlignment = .center
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 18, weight: .medium)
            return outgoing
        }
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16)
        button.configuration = config
        return button
    }()
    
    private var buttons: [UIButton] {
        [answerButton1, answerButton2, answerButton3, answerButton4]
    }
    
    private let buttonWrapper:UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawQuestion()
        self.view.backgroundColor = .yellow
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.subtitleLabel)
        self.view.addSubview(self.buttonWrapper)
        
        self.buttonWrapper.addSubview(self.answerButton1)
        self.buttonWrapper.addSubview(self.answerButton2)
        self.buttonWrapper.addSubview(self.answerButton3)
        self.buttonWrapper.addSubview(self.answerButton4)
        
        // title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        titleLabel.text = questions[currentQuestionIndex].title
        
        // subtitle
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        subtitleLabel.text = questions[currentQuestionIndex].subtitle
        
        //buttonWrapper
        buttonWrapper.translatesAutoresizingMaskIntoConstraints = false
        buttonWrapper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250).isActive = true
        buttonWrapper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonWrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        buttonWrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        buttonWrapper.widthAnchor.constraint(equalToConstant: 300).isActive = true
        buttonWrapper.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        //button 1
        answerButton1.translatesAutoresizingMaskIntoConstraints = false
        answerButton1.topAnchor.constraint(equalTo: buttonWrapper.topAnchor, constant: 20).isActive = true
        answerButton1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerButton1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        //button 2
        answerButton2.translatesAutoresizingMaskIntoConstraints = false
        answerButton2.topAnchor.constraint(equalTo: answerButton1.bottomAnchor, constant: 20).isActive = true
        answerButton2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerButton2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        //button 3
        answerButton3.translatesAutoresizingMaskIntoConstraints = false
        answerButton3.topAnchor.constraint(equalTo: answerButton2.bottomAnchor, constant: 20).isActive = true
        answerButton3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerButton3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        //button 4
        answerButton4.translatesAutoresizingMaskIntoConstraints = false
        answerButton4.topAnchor.constraint(equalTo: answerButton3.bottomAnchor, constant: 20).isActive = true
        answerButton4.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        answerButton4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        
        buttons.forEach { button in
            button.addAction(UIAction { _ in
                self.answerTapped(tag: button.tag)
            }, for: .touchUpInside)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(!isFirstLaunch) {
            self.goNext()
        }
        self.isFirstLaunch = false
    }
    
    private func answerTapped(tag: Int) {
        
        let question = questions[currentQuestionIndex]
        let isCorrect = tag == question.correctIndex
        
        if isCorrect {
            totalScore += 1
        }
        let resultVC = AnswerResultViewController(isCorrect: isCorrect, answer: question.answers[tag])
        
        resultVC.modalPresentationStyle = .fullScreen
        
        present(resultVC, animated: true)
    }
    
    
    private func drawQuestion() {
        let question = questions[currentQuestionIndex]
        titleLabel.text = question.title
        subtitleLabel.text = question.subtitle
        question.answers.enumerated().forEach { index, answer in
            buttons[index].configuration?.title = answer
        }
    }
    
    private func goNext() {
        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            drawQuestion()
        } else {
            let finalResultVC = FinalResultViewController(score: totalScore, total: questions.count)
            finalResultVC.modalPresentationStyle = .fullScreen
            present(finalResultVC, animated: true)
        }
    }
}

