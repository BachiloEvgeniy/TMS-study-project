import UIKit
import SnapKit


struct Goal {
    var title: String
    var description: String?
    var progress: Int
}

final class GoalsListViewController: UIViewController {
    
    private var goals: [Goal] = [
        Goal(title: "Помыть посуду", description: nil, progress: 0),
        Goal(title: "Помыть тачку", description: "автоматическая мой ка на заправке", progress: 0),
        Goal(title: "Забрать детей от бабушки", description: nil, progress: 0),
        Goal(title: "Почистить квартиру", description: nil, progress: 55),
        Goal(title: "Купить продукты", description: "Гиппо возле дома", progress: 30),
    ]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        label.text = "Мои цели"
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(GoalTableCell.self, forCellReuseIdentifier: "GoalTableCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .add,
            primaryAction: UIAction { [weak self] _ in
                self?.addGoal()
            }
        )
        setupUI()
    }
    
    func setupUI(){
        view.addSubview(titleLabel)
        view.addSubview(tableView)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func addGoal() {
        print("add goal")
        let vc = AddGoalViewController()
        vc.onSave = { [weak self] goal in
            self?.goals.append(goal)
            self?.tableView.reloadData()
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}


extension GoalsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalTableCell", for: indexPath) as! GoalTableCell
        cell.configure(goal: goals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = GoalDetailsController(goal: goals[indexPath.row])
        vc.onProgressChanged = { [weak self] newProgress in
            self?.goals[indexPath.row].progress = newProgress
            tableView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
