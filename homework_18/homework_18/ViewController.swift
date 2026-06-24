import UIKit

class ViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.borderWidth = 1
        return view
    }()
    
    private let smileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(
            systemName: "face.smiling",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 80)
        )
        imageView.tintColor = .yellow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let rightButton = ChevronButton(direction: .right)
    private let leftButton = ChevronButton(direction: .left)
    private let upButton = ChevronButton(direction: .up)
    private let downButton = ChevronButton(direction: .down)
    
    private var offset = CGPoint.zero
    private let step: CGFloat = 20
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        
        [leftButton, rightButton, upButton, downButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func buttonTapped(_ sender: ChevronButton) {

        var newOffset = offset
        switch sender.direction {
        case .left:
            newOffset.x -= step
        case .right:
            newOffset.x += step
        case .up:
            newOffset.y -= step
        case .down:
            newOffset.y += step
        }
        let minX = -(containerView.bounds.width - smileImageView.bounds.width) / 2
        let maxX =  (containerView.bounds.width - smileImageView.bounds.width) / 2
        let minY = -(containerView.bounds.height - smileImageView.bounds.height) / 2
        let maxY =  (containerView.bounds.height - smileImageView.bounds.height) / 2
        newOffset.x = min(max(newOffset.x, minX), maxX)
        newOffset.y = min(max(newOffset.y, minY), maxY)
        offset = newOffset
        UIView.animate(withDuration: 0.25) {
            self.smileImageView.transform = CGAffineTransform(
                translationX: self.offset.x,
                y: self.offset.y
            )
        }
    }
    
    private func setupUi() {
        view.backgroundColor = .white
        
        // container
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        // smile
        containerView.addSubview(smileImageView)
        NSLayoutConstraint.activate([
            smileImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            smileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            smileImageView.widthAnchor.constraint(equalToConstant: 80),
            smileImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // buttons
        let stackView = UIStackView(arrangedSubviews: [leftButton, upButton, downButton, rightButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 30
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}


