import UIKit

final class MainTabBarController: UITabBarController {

    private let screenFactory: ScreenFactory

    init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureTabs()
    }

    private func configureTabs() {
        setViewControllers(
            [makeWeatherTab(), makeMapTab()],
            animated: false
        )
    }

    private func makeWeatherTab() -> UINavigationController {
        let navigationController = UINavigationController(
            rootViewController: screenFactory.makeWeatherTodayScreen()
        )
        navigationController.tabBarItem = UITabBarItem(
            title: "Погода",
            image: UIImage(systemName: "cloud.sun"),
            selectedImage: UIImage(systemName: "cloud.sun.fill")
        )
        return navigationController
    }

    private func makeMapTab() -> UINavigationController {
        let navigationController = UINavigationController(
            rootViewController: screenFactory.makeWeatherMapScreen()
        )
        navigationController.tabBarItem = UITabBarItem(
            title: "Карта",
            image: UIImage(systemName: "map"),
            selectedImage: UIImage(systemName: "map.fill")
        )

        return navigationController
    }

    private func configureAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}
