import UIKit

class ViewController: UIViewController {
    
    private let pizzaSizes = [
        "Маленькая 25см",
        "Средняя 30см",
        "Большая 35см",
        "Семейная 45см"
    ]
    
    private let doughTypes = [
        "Тонкое",
        "Традиционное",
        "Пышное",
        "Сырный бортик"
    ]
    
    private let deliveryCities = [
        "Москва",
        "Санкт-Петербург",
        "Казань",
        "Екатеринбург",
        "Новосибирск"
    ]
    
    private var stackViewInputs: UIStackView!
    private var stackViewTopings: UIStackView!
    private var stackViewImagePicker: UIStackView!
    
    // inputs
    private lazy var sizeTextField: UITextField = self.createTextField(placeholder: "Выберите размер пиццы")
    
    private lazy var doughTextField: UITextField = self.createTextField(placeholder: "Выберите тип теста")
   
    private lazy var cityTextField: UITextField = self.createTextField(placeholder: "Выберите город доставки")
    
    private let sizePickerView = UIPickerView()
    private let doughPickerView = UIPickerView()
    private let cityPickerView = UIPickerView()
    
    // toping
    
    
    private var selectedToppings: [String] = Array(repeating: "", count: 5)
    
    private lazy var selectToppingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать топпинги", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.addTarget(
            self,
            action: #selector(selectToppingsButtonTapped),
            for: .touchUpInside
        )
        return button

    }()
    
    private let toppingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Без топпингов"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // image
    
    private let receiptTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавьте фото чека (опционально)"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var selectedReceiptImage: UIImage?
    
    private lazy var receiptImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(systemName: "camera")
        imageView.tintColor = .secondaryLabel
        imageView.backgroundColor = .secondarySystemBackground

        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.separator.cgColor

        imageView.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(receiptImageViewTapped)
        )

        imageView.addGestureRecognizer(tapGesture)

        return imageView
    }()
    
    private let photoStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Фото добавлено"
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center

        label.isHidden = true

        return label
    }()
    
    // submit button
    
    private lazy var orderButton: UIButton = {
        let button = UIButton(type: .system)

        button.setTitle("Оформить заказ", for: .normal)
        button.setTitleColor(.white, for: .normal)

        button.titleLabel?.font = .systemFont(
            ofSize: 18,
            weight: .semibold
        )

        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12

        button.addTarget(
            self,
            action: #selector(orderButtonTapped),
            for: .touchUpInside
        )

        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapOutside)
        )
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        setupInputs()
        configurePickers()
        configureTextFields()
        setupTopings()
        setupImagePicker()
    }
    
    @objc private func orderButtonTapped() {
        guard validateOrder() else {
            return
        }

        showOrderSummary()
    }
    
    private func validateOrder() -> Bool {
        if sizeTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty == true {
            
            showValidationAlert(fieldName: "размер пиццы")
            return false
        }

        if doughTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty == true {
            
            showValidationAlert(fieldName: "тип теста")
            return false
        }

        if cityTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty == true {
            
            showValidationAlert(fieldName: "город доставки")
            return false
        }

        return true
    }
    
    private func showValidationAlert(fieldName: String) {
        let alert = UIAlertController(
            title: "Заполните обязательное поле",
            message: "Необходимо выбрать \(fieldName).",
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "ОК",
                style: .default
            )
        )

        present(alert, animated: true)
    }
    
    private func calculateTotalPrice() -> Int {
        guard
            let selectedSize = sizeTextField.text,
            let selectedDough = doughTextField.text
        else {
            return 0
        }

        let basePrice: Int

        switch selectedSize {
        case "Маленькая 25см":
            basePrice = 400

        case "Средняя 30см":
            basePrice = 600

        case "Большая 35см":
            basePrice = 800

        case "Семейная 45см":
            basePrice = 1100

        default:
            basePrice = 0
        }

        let nonEmptyToppings = selectedToppings.filter {
            !$0.trimmingCharacters(
                in: .whitespacesAndNewlines
            ).isEmpty
        }

        let toppingsPrice = nonEmptyToppings.count * 50

        let cheeseBorderPrice: Int

        if selectedDough == "Сырный бортик" {
            cheeseBorderPrice = 150
        } else {
            cheeseBorderPrice = 0
        }

        return basePrice + toppingsPrice + cheeseBorderPrice
    }
    
    private func showOrderSummary() {
        let size = sizeTextField.text ?? ""
        let dough = doughTextField.text ?? ""
        let city = cityTextField.text ?? ""

        let nonEmptyToppings = selectedToppings.filter {
            !$0.trimmingCharacters(
                in: .whitespacesAndNewlines
            ).isEmpty
        }

        let toppingsText = nonEmptyToppings.isEmpty
            ? "Без топпингов"
            : nonEmptyToppings.joined(separator: ", ")

        let receiptPhotoText = selectedReceiptImage == nil
            ? "Не добавлено"
            : "Добавлено"

        let totalPrice = calculateTotalPrice()

        let message = """
        Размер: \(size)
        Тесто: \(dough)
        Топпинги: \(toppingsText)
        Город доставки: \(city)
        Фото чека: \(receiptPhotoText)

        Итоговая цена: \(totalPrice) ₽
        """

        let actionSheet = UIAlertController(
            title: "Ваш заказ",
            message: message,
            preferredStyle: .actionSheet
        )

        let confirmAction = UIAlertAction(
            title: "Подтвердить заказ",
            style: .default
        ) { [weak self] _ in
            self?.showFinalAlert(totalPrice: totalPrice)
        }

        let cancelAction = UIAlertAction(
            title: "Отмена",
            style: .cancel
        )

        actionSheet.addAction(confirmAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
    
    private func showFinalAlert(totalPrice: Int) {
        let title: String
        let message: String

        if totalPrice > 2000 {
            title = "Поздравляем!"
            message = "Вам доступна бесплатная доставка"
        } else {
            title = "Заказ оформлен"
            message = "Спасибо за ваш заказ!"
        }

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(
            title: "ОК",
            style: .default
        ) { [weak self] _ in
            self?.resetOrderForm()
        }

        alert.addAction(okAction)

        present(alert, animated: true)
    }
    
    private func resetOrderForm() {
        // Первая секция
        sizeTextField.text = nil
        doughTextField.text = nil
        cityTextField.text = nil

        sizePickerView.selectRow(
            0,
            inComponent: 0,
            animated: false
        )

        doughPickerView.selectRow(
            0,
            inComponent: 0,
            animated: false
        )

        cityPickerView.selectRow(
            0,
            inComponent: 0,
            animated: false
        )

        // Вторая секция
        selectedToppings = Array(
            repeating: "",
            count: 5
        )

        toppingsLabel.text = "Без топпингов"

        // Третья секция
        selectedReceiptImage = nil

        receiptImageView.image = UIImage(
            systemName: "camera"
        )

        receiptImageView.contentMode = .scaleAspectFit
        photoStatusLabel.isHidden = true
        photoStatusLabel.attributedText = nil
    }
    
    private func setupImagePicker() {
         stackViewImagePicker = UIStackView(
            arrangedSubviews: [
                receiptTitleLabel,
                receiptImageView,
                photoStatusLabel,
                orderButton
            ]
        )

        stackViewImagePicker.axis = .vertical
        stackViewImagePicker.spacing = 12
        stackViewImagePicker.alignment = .fill
        stackViewImagePicker.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackViewImagePicker)

        NSLayoutConstraint.activate([
            stackViewImagePicker.topAnchor.constraint(
                equalTo: stackViewTopings.bottomAnchor,
                constant: 40
            ),

            stackViewImagePicker.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),

            stackViewImagePicker.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),

            receiptImageView.heightAnchor.constraint(
                equalToConstant: 220
            )
        ])
    }
    
    @objc private func receiptImageViewTapped() {
        let actionSheet = UIAlertController(
            title: "Фото чека",
            message: "Выберите источник фотографии",
            preferredStyle: .actionSheet
        )

        let cameraAction = UIAlertAction(
            title: "Сделать фото",
            style: .default
        ) { [weak self] _ in
            self?.openImagePicker(sourceType: .camera)
        }

        let galleryAction = UIAlertAction(
            title: "Выбрать из галереи",
            style: .default
        ) { [weak self] _ in
            self?.openImagePicker(sourceType: .photoLibrary)
        }

        let cancelAction = UIAlertAction(
            title: "Отмена",
            style: .cancel
        )

        actionSheet.addAction(cameraAction)
        actionSheet.addAction(galleryAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true)
    }
    
    private func openImagePicker(
        sourceType: UIImagePickerController.SourceType
    ) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            showSourceUnavailableAlert(sourceType: sourceType)
            return
        }

        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = false

        present(imagePicker, animated: true)
    }
    
    private func showSourceUnavailableAlert(
        sourceType: UIImagePickerController.SourceType
    ) {
        let sourceName: String

        switch sourceType {
        case .camera:
            sourceName = "Камера"

        case .photoLibrary:
            sourceName = "Галерея"

        case .savedPhotosAlbum:
            sourceName = "Альбом фотографий"

        @unknown default:
            sourceName = "Источник изображения"
        }

        let alert = UIAlertController(
            title: "Ошибка",
            message: "\(sourceName) недоступна на этом устройстве.",
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "ОК",
                style: .default
            )
        )

        present(alert, animated: true)
    }
    
    @objc private func selectToppingsButtonTapped() {
        let alert = UIAlertController(
            title: "Выберите топпинги",
            message: "Введите до пяти топпингов",
            preferredStyle: .alert
        )
        
        for index in 0..<5 {
            alert.addTextField { [weak self] textField in
                textField.placeholder = "Топпинг \(index + 1)"
                textField.text = self?.selectedToppings[index]
                textField.clearButtonMode = .whileEditing
            }
        }
        
        let cancelAction = UIAlertAction(
            title: "Отмена",
            style: .cancel
        )
        let doneAction = UIAlertAction(
            title: "Готово",
            style: .default
        ) { [weak self, weak alert] _ in
            guard
                let self,
                let textFields = alert?.textFields
            else {
                return
            }
            self.selectedToppings = textFields.map {
                $0.text?.trimmingCharacters(
                    in: .whitespacesAndNewlines
                ) ?? ""
            }
            self.updateToppingsLabel()
        }
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        present(alert, animated: true)
    }
    
    private func updateToppingsLabel() {
        let nonEmptyToppings = selectedToppings.filter {
            !$0.isEmpty
        }
        if nonEmptyToppings.isEmpty {
            toppingsLabel.text = "Без топпингов"
        } else {
            toppingsLabel.text = nonEmptyToppings.joined(
                separator: ", "
            )
        }
    }
    
    private func setupTopings() {
        stackViewTopings = UIStackView(
            arrangedSubviews: [
                selectToppingsButton,
                toppingsLabel
            ]
        )
        stackViewTopings.axis = .vertical
        stackViewTopings.spacing = 16
        stackViewTopings.alignment = .fill
        stackViewTopings.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewTopings)
        NSLayoutConstraint.activate([
            stackViewTopings.topAnchor.constraint(
                equalTo: stackViewInputs.bottomAnchor,
                constant: 40
            ),
            stackViewTopings.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            stackViewTopings.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            selectToppingsButton.heightAnchor.constraint(
                equalToConstant: 50
            )
        ])
    }
    
    private func configureTextFields() {

        sizeTextField.inputView = sizePickerView
        doughTextField.inputView = doughPickerView
        cityTextField.inputView = cityPickerView

        sizeTextField.inputAccessoryView = makeToolbar(
            action: #selector(sizePickerDoneButtonTapped)
        )
        doughTextField.inputAccessoryView = makeToolbar(
            action: #selector(doughPickerDoneButtonTapped)
        )
        cityTextField.inputAccessoryView = makeToolbar(
            action: #selector(cityPickerDoneButtonTapped)
        )
    }
    
    @objc private func sizePickerDoneButtonTapped() {
        let selectedRow = sizePickerView.selectedRow(inComponent: 0)
        sizeTextField.text = pizzaSizes[selectedRow]
        sizeTextField.resignFirstResponder()
    }

    @objc private func doughPickerDoneButtonTapped() {
        let selectedRow = doughPickerView.selectedRow(inComponent: 0)
        doughTextField.text = doughTypes[selectedRow]
        doughTextField.resignFirstResponder()
    }
    
    @objc private func cityPickerDoneButtonTapped() {
        let selectedRow = cityPickerView.selectedRow(inComponent: 0)
        cityTextField.text = deliveryCities[selectedRow]
        cityTextField.resignFirstResponder()
    }
    
    @objc private func didTapOutside() {
        view.endEditing(true)
    }
    
    
    
    private func makeToolbar(action: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: "Готово",
            style: UIBarButtonItem.Style.prominent,
            target: self,
            action: action
        )
        toolbar.items = [
            flexibleSpace,
            doneButton
        ]
        return toolbar
    }
    
    private func setupInputs() {
        stackViewInputs = UIStackView(arrangedSubviews: [sizeTextField, doughTextField, cityTextField])
        stackViewInputs.axis = .vertical
        stackViewInputs.spacing = 16
        stackViewInputs.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewInputs)
        
        NSLayoutConstraint.activate([
            stackViewInputs.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackViewInputs.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackViewInputs.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func createTextField(placeholder: String)->UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        return textField
    }
    
    private func configurePickers() {

        let pickers = [
            sizePickerView,
            doughPickerView,
            cityPickerView
        ]
        pickers.forEach {
            $0.delegate = self
            $0.dataSource = self
        }

    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
               case sizePickerView:
            return pizzaSizes.count
               case doughPickerView:
                   return doughTypes.count
               case cityPickerView:
                   return deliveryCities.count
               default:
                   return 0
               }
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        switch pickerView {
        case sizePickerView:
            return pizzaSizes[row]
        case doughPickerView:
            return doughTypes[row]
        case cityPickerView:
            return deliveryCities[row]
        default:
            return nil
        }
    }

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        switch pickerView {
        case sizePickerView:
            sizeTextField.text = pizzaSizes[row]
        case doughPickerView:
            doughTextField.text = doughTypes[row]
        case cityPickerView:
            cityTextField.text = deliveryCities[row]
        default:
            break
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ViewController:
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [
            UIImagePickerController.InfoKey: Any
        ]
    ) {
        let selectedImage = info[.originalImage] as? UIImage

        if let selectedImage {
            selectedReceiptImage = selectedImage
            receiptImageView.image = selectedImage
            receiptImageView.contentMode = .scaleAspectFill
            photoStatusLabel.isHidden = false
        }

        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(
        _ picker: UIImagePickerController
    ) {
        picker.dismiss(animated: true)
    }
}
