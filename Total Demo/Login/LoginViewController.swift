//
//  LoginViewController.swift
//  Total Demo
//
//  Created by Nimish Gupta on 10/11/24.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    
    private let vm: LoginViewModel = LoginViewModel()
    
    private var subscribers: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_email.delegate = self
        txt_password.delegate = self
        bindData()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btn_refreshAction(_ sender: UIButton) {
        vm.refreshScreen()
    }
    
    @IBAction func btn_loginAction(_ sender: UIButton) {
        switch vm.validateData() {
        case .success:
            vm.delegate = self
            vm.loginApiRequest()
        case let .failure(err: err):
            showAlert(desc: err.description)
        }
    }
    
    private func bindData() {
        subscribers = [
            vm.$username.assign(to: \.text!, on: txt_email),
            vm.$password.assign(to: \.text!, on: txt_password)
        ]
    }
    
   
    private func showAlert(desc: String){
        Task {@MainActor in
            let alert = UIAlertController(title: "Oooopss!!", message: desc, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}


extension LoginViewController: HandleAPICallFlow {
    func handleSuccessFlow(res: LoginResponseModel) {
        Task {@MainActor in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.vm = HomeViewModel(id: res.id)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func handleFailureFlow(errString: String) {
        showAlert(desc: errString)
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txt_email {
            vm.username = textField.text ?? ""
        } else{
            vm.password = textField.text ?? ""
        }
    }
}


