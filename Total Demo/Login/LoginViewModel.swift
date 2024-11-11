//
//  LoginViewModel.swift
//  Total Demo
//
//  Created by Nimish Gupta on 10/11/24.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    @Published var username: String = "emilys"
    @Published var password: String = "emilyspass"
    
    weak var delegate: HandleAPICallFlow?
    
    func refreshScreen() {
        username = ""
        password = ""
    }
    
    func validateData() -> ValidationResult {
        if username.isEmpty || password.isEmpty {
            return .failure(err: .EmptyFields)
        } else if password.count < 2 {
            return .failure(err: .PasswordLengthTooShort)
        } else {
            return .success
        }
    }
    
    func loginApiRequest() {
        let reqModel = LoginRequestModel(username: username, password: password)
        Task{
            switch await APIHelper.shared.loginApiCall(reqModel: reqModel) {
            case let .success(res):
                delegate?.handleSuccessFlow(res: res)
            case let .failure(err):
                delegate?.handleFailureFlow(errString: err.rawValue)
            }
        }
    }
}

enum ValidationResult{
    case success
    case failure(err: ValidationError)
}

enum ValidationError{
    case EmptyFields
    case PasswordLengthTooShort
    
    var description: String {
        switch self {
        case .EmptyFields:
            return "Username and password cant be empty!!"
        case .PasswordLengthTooShort:
            return "Password length too short!!"
        }
    }
}


protocol HandleAPICallFlow: AnyObject {
    func handleSuccessFlow(res: LoginResponseModel)
    func handleFailureFlow(errString: String)
}
