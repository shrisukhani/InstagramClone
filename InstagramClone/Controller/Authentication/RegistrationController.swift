//
//  RegistrationController.swift
//  InstagramClone
//
//  Created by Shridhar Sukhani on 1/14/21.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private let plusImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullnameTextField = CustomTextField(placeholder: "Fullname")
    
    private let usernameTextField = CustomTextField(placeholder: "Username")
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.setHeight(50)
        return button
    }()
    
    private let alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleAlreadyHaveAnAccountTap), for: .touchUpInside)
        button.setAttributedTitle(firstPart: "Already have an account?", secondPart: "Log in")
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Actions
    @objc func handleAlreadyHaveAnAccountTap(_ button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        configureGradientLayer()
        
        // plusImageButton
        view.addSubview(plusImageButton)
        plusImageButton.centerX(inView: view)
        plusImageButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        // stack
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField,
                                                   fullnameTextField, usernameTextField,
                                                   signupButton])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: plusImageButton.bottomAnchor, left: view.leadingAnchor,
                     paddingTop: 32, paddingLeft: 32)
        stack.setWidth(view.frame.width - 64)
        
        // alreadyHaveAnAccountButton
        view.addSubview(alreadyHaveAnAccountButton)
        alreadyHaveAnAccountButton.centerX(inView: view)
        alreadyHaveAnAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
