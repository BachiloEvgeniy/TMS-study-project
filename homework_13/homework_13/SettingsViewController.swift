import UIKit

struct SettingsItem {
    let title: String
    let icon: String
    let color: UIColor
}

class SettingsViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let sections: [[SettingsItem]] = [
        [
            SettingsItem(title: "Face ID и код-пароль", icon: "faceid", color: .systemGreen),
            SettingsItem(title: "Экстренный вызов — SOS", icon: "sos", color: .systemRed),
            SettingsItem(title: "Конфиденциальность\nи безопасность", icon: "hand.raised.fill", color: .systemBlue)
        ],
        [
            SettingsItem(title: "Game Center", icon: "gamecontroller.fill", color: .systemPink),
            SettingsItem(title: "iCloud", icon: "icloud.fill", color: .systemBlue),
            SettingsItem(title: "Wallet и Apple Pay", icon: "wallet.pass.fill", color: .systemOrange)
        ],
        [
            SettingsItem(title: "Приложения", icon: "square.grid.3x3.fill", color: .yellow)
        ]
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTableView()
        title = "Настройки"
        let appearance = UINavigationBarAppearance()
          appearance.titleTextAttributes = [
              .foregroundColor: UIColor.gray
          ]
          navigationController?.navigationBar.standardAppearance = appearance
          navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.2)
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
}
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].count
    }

    func tableView(

        _ tableView: UITableView,

        cellForRowAt indexPath: IndexPath

    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingsCell.identifier,
            for: indexPath
        ) as! SettingsCell
        cell.configure(with: sections[indexPath.section][indexPath.row])
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        58
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingsViewController = SettingDetailsViewController(settingName: sections[indexPath.section][indexPath.row].title)
        navigationController?.pushViewController(settingsViewController, animated: true)
        
    }
}
