import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let uiKitButton = UIButton(type: .system)
    private let swiftUIButton = UIButton(type: .system)
    private let descriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Swift Demo"
        
        // 配置标题
        titleLabel.text = "iOS开发技术栈演示"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        
        // 配置UIKit按钮
        uiKitButton.setTitle("UIKit 演示", for: .normal)
        uiKitButton.backgroundColor = .systemBlue
        uiKitButton.setTitleColor(.white, for: .normal)
        uiKitButton.layer.cornerRadius = 10
        uiKitButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        uiKitButton.addTarget(self, action: #selector(showUIKitDemo), for: .touchUpInside)
        
        // 配置SwiftUI按钮
        swiftUIButton.setTitle("SwiftUI 演示", for: .normal)
        swiftUIButton.backgroundColor = .systemGreen
        swiftUIButton.setTitleColor(.white, for: .normal)
        swiftUIButton.layer.cornerRadius = 10
        swiftUIButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        swiftUIButton.addTarget(self, action: #selector(showSwiftUIDemo), for: .touchUpInside)
        
        // 配置描述文本
        descriptionLabel.text = """
        这个演示项目展示了两种主要的iOS UI开发方式：
        
        • UIKit: 传统的命令式UI框架
        • SwiftUI: 现代的声明式UI框架
        
        点击按钮查看具体实现
        """
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .secondaryLabel
        
        // 配置堆栈视图
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        // 添加子视图
        [titleLabel, uiKitButton, swiftUIButton, descriptionLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40),
            
            uiKitButton.heightAnchor.constraint(equalToConstant: 50),
            swiftUIButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func showUIKitDemo() {
        let uiKitDemoVC = UIKitDemoViewController()
        navigationController?.pushViewController(uiKitDemoVC, animated: true)
    }
    
    @objc private func showSwiftUIDemo() {
        let contentView = ContentView()
        let hostingController = UIHostingController(rootView: contentView)
        hostingController.title = "SwiftUI Demo"
        navigationController?.pushViewController(hostingController, animated: true)
    }
}

// MARK: - UIKit Demo View Controller
class UIKitDemoViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let counterLabel = UILabel()
    private let incrementButton = UIButton(type: .system)
    private let decrementButton = UIButton(type: .system)
    private let textField = UITextField()
    private let submitButton = UIButton(type: .system)
    private let resultLabel = UILabel()
    private let colorButton = UIButton(type: .system)
    
    private var counter = 0 {
        didSet {
            counterLabel.text = "计数器: \(counter)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "UIKit 演示"
        
        // 滚动视图
        scrollView.showsVerticalScrollIndicator = true
        
        // 堆栈视图
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        // 计数器标签
        counterLabel.text = "计数器: 0"
        counterLabel.font = .boldSystemFont(ofSize: 20)
        counterLabel.textAlignment = .center
        counterLabel.backgroundColor = .systemGray6
        counterLabel.layer.cornerRadius = 10
        counterLabel.layer.masksToBounds = true
        
        // 增加按钮
        incrementButton.setTitle("增加", for: .normal)
        incrementButton.backgroundColor = .systemBlue
        incrementButton.setTitleColor(.white, for: .normal)
        incrementButton.layer.cornerRadius = 8
        incrementButton.addTarget(self, action: #selector(incrementCounter), for: .touchUpInside)
        
        // 减少按钮
        decrementButton.setTitle("减少", for: .normal)
        decrementButton.backgroundColor = .systemRed
        decrementButton.setTitleColor(.white, for: .normal)
        decrementButton.layer.cornerRadius = 8
        decrementButton.addTarget(self, action: #selector(decrementCounter), for: .touchUpInside)
        
        // 文本输入框
        textField.placeholder = "请输入文本..."
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 16)
        
        // 提交按钮
        submitButton.setTitle("提交文本", for: .normal)
        submitButton.backgroundColor = .systemGreen
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 8
        submitButton.addTarget(self, action: #selector(submitText), for: .touchUpInside)
        
        // 结果标签
        resultLabel.text = "输入的文本将显示在这里"
        resultLabel.numberOfLines = 0
        resultLabel.textAlignment = .center
        resultLabel.font = .systemFont(ofSize: 16)
        resultLabel.backgroundColor = .systemGray6
        resultLabel.layer.cornerRadius = 10
        resultLabel.layer.masksToBounds = true
        
        // 颜色切换按钮
        colorButton.setTitle("切换背景颜色", for: .normal)
        colorButton.backgroundColor = .systemPurple
        colorButton.setTitleColor(.white, for: .normal)
        colorButton.layer.cornerRadius = 8
        colorButton.addTarget(self, action: #selector(toggleBackgroundColor), for: .touchUpInside)
        
        // 添加子视图到堆栈
        [counterLabel, incrementButton, decrementButton, textField, submitButton, resultLabel, colorButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            counterLabel.heightAnchor.constraint(equalToConstant: 50),
            incrementButton.heightAnchor.constraint(equalToConstant: 44),
            decrementButton.heightAnchor.constraint(equalToConstant: 44),
            textField.heightAnchor.constraint(equalToConstant: 44),
            submitButton.heightAnchor.constraint(equalToConstant: 44),
            resultLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            colorButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func incrementCounter() {
        counter += 1
        animateButton(incrementButton)
    }
    
    @objc private func decrementCounter() {
        counter -= 1
        animateButton(decrementButton)
    }
    
    @objc private func submitText() {
        let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if text.isEmpty {
            resultLabel.text = "请输入一些文本"
        } else {
            resultLabel.text = "您输入的文本是：\n\(text)"
        }
        textField.resignFirstResponder()
        animateButton(submitButton)
    }
    
    @objc private func toggleBackgroundColor() {
        let colors: [UIColor] = [.systemBackground, .systemGray6, .systemBlue.withAlphaComponent(0.1), .systemGreen.withAlphaComponent(0.1)]
        let currentColor = view.backgroundColor
        let nextColor = colors.randomElement() ?? .systemBackground
        
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = nextColor
        }
        animateButton(colorButton)
    }
    
    private func animateButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity
            }
        }
    }
}