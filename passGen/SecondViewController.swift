import Foundation
import UIKit
import SnapKit

class SecondViewController: UIViewController {
    let generateLabel: UILabel = {
        let label = UILabel()
          label.textAlignment = .center
          label.font = UIFont.systemFont(ofSize: 18)
          label.numberOfLines = 0
          return label
    }()
    let backImage: UIImageView = {
        let image = UIImageView(frame: UIScreen.main.bounds)
        image.image = UIImage(named: "backimage")
        image.contentMode = .scaleToFill
        return image
    }()
    let generateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.setTitle("Generate", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(generateButtonTapped), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarFunc()
        view.addSubview(generateButton)
        view.addSubview(generateLabel)
        generateLabel.isUserInteractionEnabled = true
        generateLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        makeConstraints()
        self.view.insertSubview(backImage, at: 0)

     //   self.view.backgroundColor = UIColor(patternImage: UIImage(named: "dog"))

      
        
    }

    func makeConstraints() {
        generateButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        generateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
        }
    }

    private func tabBarFunc() {
        var tabBarItem = UITabBarItem()
        let homeIcon = UIImage(systemName: "person.fill")
        tabBarItem = UITabBarItem(title: "Генератор", image: homeIcon, tag: 2)
        self.tabBarItem = tabBarItem
        self.navigationItem.title = "Генератор паролей"
    }

 
    @objc private func generateButtonTapped() {
        let generatedPassword = generateRandomPassword(length: 12)
        generateLabel.text = generatedPassword
    }

    private func generateRandomPassword(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomChars = (0..<length).map { _ in
            allowedChars.randomElement()!
        }
        return String(randomChars)
    }
    @objc private func labelTapped() {
         if let generatedPassword = generateLabel.text {
             UIPasteboard.general.string = generatedPassword
             let alert = UIAlertController(title: "Скопировано", message: "Текст скопирован в буфер обмена", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
             present(alert, animated: true, completion: nil)
         }
     }
}
