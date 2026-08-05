import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureTabs()
    }

    private func configureTabs() {
        let weatherViewController = WeatherTodayViewController()
        let weatherNavigationController = UINavigationController(
            rootViewController: weatherViewController
        )
        weatherNavigationController.tabBarItem = UITabBarItem(
            title: "Погода",
            image: UIImage(systemName: "cloud.sun"),
            selectedImage: UIImage(systemName: "cloud.sun.fill")
        )

        let mapViewController = WeatherMapViewController()
        let mapNavigationController = UINavigationController(
            rootViewController: mapViewController
        )
        mapNavigationController.tabBarItem = UITabBarItem(
            title: "Карта",
            image: UIImage(systemName: "map"),
            selectedImage: UIImage(systemName: "map.fill")
        )

        setViewControllers(
            [weatherNavigationController, mapNavigationController],
            animated: false
        )
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
