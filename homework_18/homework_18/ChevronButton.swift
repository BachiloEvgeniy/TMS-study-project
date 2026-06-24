import UIKit

final class ChevronButton: UIButton {
    
    let direction: Direction

    enum Direction {
        case left
        case right
        case up
        case down

        var systemImageName: String {
            switch self {
            case .left:  return "chevron.left"
            case .right: return "chevron.right"
            case .up:    return "chevron.up"
            case .down:  return "chevron.down"
            }
        }
    }


    init(direction: Direction) {
        self.direction = direction
        super.init(frame: .zero)
        let image = UIImage(systemName: direction.systemImageName)
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .blue
        config.image = image
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        configuration = config
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 60),
            heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

