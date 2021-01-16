//
//  AuthenticationViewModel.swift
//  InstagramClone
//
//  Created by Shridhar Sukhani on 1/15/21.
//

import UIKit

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonIsEnabled: Bool { get }
    var buttonTitleColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var emailId: String?
    var password: String?
    
    var formIsValid: Bool {
        guard let emailId = emailId, let password = password else { return false }
        return !(emailId.isEmpty || password.isEmpty)
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ?  #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonIsEnabled: Bool {
        return formIsValid
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : .init(white: 1, alpha: 0.67)
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        guard let emailId = email, let password = password,
              let fullname = fullname, let username = username else { return false }
        return !(emailId.isEmpty || password.isEmpty || fullname.isEmpty || username.isEmpty)
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ?  #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonIsEnabled: Bool {
        return formIsValid
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : .init(white: 1, alpha: 0.67)
    }
}
