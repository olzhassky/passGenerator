import UIKit

class ViewController: UIViewController {

    let passManager = PassManager()
    let table = UITableView()
    var isPasswordVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tabBarFunc()
        setupNavigationBar()
    }

    private func setupUI() {
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        table.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        let showButtonImageName = isPasswordVisible ? "eye.fill" : "eye.slash.fill"
            let showButton = UIBarButtonItem(image: UIImage(systemName: showButtonImageName), style: .plain, target: self, action: #selector(showHideButtonTapped))
            navigationItem.leftBarButtonItem = showButton
    }

    @objc private func addButtonTapped() {
        let alertController = UIAlertController(title: "Add Account", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Username"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let usernameField = alertController.textFields?.first,
                  let passwordField = alertController.textFields?.last,
                  let username = usernameField.text,
                  let password = passwordField.text else {
                return
            }
            self?.passManager.addAcc(login: username, password: password)
            self?.table.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
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
            isPasswordVisible.toggle()
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
        cell.textLabel?.text = "\(account.login): \(isPasswordVisible ? account.password : "*****")"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        passManager.accounts[indexPath.row].isPasswordVisible.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}
