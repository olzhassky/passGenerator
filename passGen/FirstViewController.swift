import UIKit
import SnapKit

class ViewController: UIViewController {

    let passManager = PassManager()
    let table = UITableView()
    var isVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        makeConstraints()
        tabBarFunc()
        setupNavigationBar()
        
    }
    private func makeConstraints() {
        table.snp.makeConstraints {
               $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
               $0.leading.equalToSuperview()
               $0.trailing.equalToSuperview()
               $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
           }
    }

    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        let showButtonImageName = isVisible ? "eye.fill" : "eye.slash.fill"
            let showButton = UIBarButtonItem(image: UIImage(systemName: showButtonImageName), style: .plain, target: self, action: #selector(showHideButtonTapped))
            navigationItem.leftBarButtonItem = showButton
    }

    @objc private func addButtonTapped() {
        let alertController = UIAlertController(title: "Добавить аккаунт", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Логин"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Пароль"
            textField.isSecureTextEntry = true
        }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            guard let usernameField = alertController.textFields?.first,
                  let passwordField = alertController.textFields?.last,
                  let username = usernameField.text,
                  let password = passwordField.text else {
                return
            }
            self?.passManager.addAcc(login: username, password: password)
            self?.table.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    private func tabBarFunc() {
        var tabBarItem = UITabBarItem()
        let homeIcon = UIImage(systemName: "house.fill")
        tabBarItem = UITabBarItem(title: "Home", image: homeIcon, tag: 1)
        self.tabBarItem = tabBarItem
        self.navigationItem.title = "Home"
        view.backgroundColor = .systemBackground
    }
        @objc private func showHideButtonTapped() {
            isVisible.toggle()
            table.reloadData()
            setupNavigationBar()
        }
    }


extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passManager.accounts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let account = passManager.accounts[indexPath.row]
        cell.textLabel?.text = "Login: \(isVisible ? account.login: "*****") Password: \(isVisible ? account.password : "*****")"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertController = UIAlertController(title: "Редактировать", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Логин"
            textField.text = self.passManager.accounts[indexPath.row].login
        }
        alertController.addTextField { textField in
            textField.placeholder = "Пароль"
            textField.isSecureTextEntry = true
            textField.text = self.passManager.accounts[indexPath.row].password
        }
        
        let editAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            guard let usernameField = alertController.textFields?.first,
                  let passwordField = alertController.textFields?.last,
                  let username = usernameField.text,
                  let password = passwordField.text else {
                return
            }
            self?.passManager.accounts[indexPath.row].login = username
            self?.passManager.accounts[indexPath.row].password = password
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        alertController.addAction(editAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    

}
