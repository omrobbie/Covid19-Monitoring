//
//  LoginVC.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 03/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtEmailWarning: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPasswordWarning: UILabel!
    @IBOutlet weak var btnLogin: CustomUIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
    }

    private func setupDelegate() {
        txtEmail.delegate = self
        txtPassword.delegate = self
    }

    private func showWarningWhenTextIsEmpty() {
        txtEmailWarning.isHidden = !txtEmail.text!.isEmpty
        txtPasswordWarning.isHidden = !txtPassword.text!.isEmpty
    }

    @IBAction func btnLoginTapped(_ sender: Any) {
        showWarningWhenTextIsEmpty()

        guard let email = txtEmail.text,
            let password = txtPassword.text
            else {
                return
        }

        if email == "putu.roby@yahoo.com" && password == "1234" {
            print("Login Success!")
        }
    }
}

extension LoginVC: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        showWarningWhenTextIsEmpty()
        btnLogin.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
}
