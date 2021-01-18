//
//  RegistrationController.swift
//  InstagramClone
//
//  Created by Shridhar Sukhani on 1/14/21.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: RegistrationViewModel = RegistrationViewModel()
    
    private lazy var plusImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePictureButtonTap), for: .touchUpInside)
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
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.setTitleColor(.init(white: 1, alpha: 0.67), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
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
    
    @objc func handleProfilePictureButtonTap(_ button: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == usernameTextField {
            viewModel.username = sender.text
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        }
        
        signupButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signupButton.backgroundColor = viewModel.buttonBackgroundColor
        signupButton.isEnabled = viewModel.buttonIsEnabled
    }
    
    @objc func handleSignup(_ sender: UITextField) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullname = fullnameTextField.text,
              let username = usernameTextField.text,
              let profileImage = plusImageButton.currentImage else {
            return
        }
        
        let credentials = AuthCredentials(email: email,
                                          password: password,
                                          fullname: fullname,
                                          username: username,
                                          profilePicture: profileImage)
        
        AuthService.registerUser(withCredentials: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to register user: \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: Successfully Registered User with Firebase")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        // plusImageButton
        view.addSubview(plusImageButton)
        plusImageButton.centerX(inView: view)
        plusImageButton.setDimensions(height: 180, width: 180)
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
        
        configureNotificationObservers()
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        plusImageButton.layer.cornerRadius = plusImageButton.frame.width / 2
        plusImageButton.layer.masksToBounds = true
        plusImageButton.layer.borderColor = UIColor.white.cgColor
        plusImageButton.layer.borderWidth = 2
        plusImageButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        self.dismiss(animated: true, completion: nil)
    }
}
