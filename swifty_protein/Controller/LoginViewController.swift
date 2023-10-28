//
//  LoginViewController.swift
//  swifty_protein
//
//  Created by Yvann Martorana on 24/05/2021.
//

import UIKit
import SwiftKeychainWrapper
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var touchIDButton: UIButton!
    @IBOutlet weak var faceIDButton: UIButton!
    @IBOutlet weak var passcodeInput: UITextField!
    @IBOutlet weak var switchLabel: UILabel!
    
    @IBAction func touchAuthAction(_ sender: Any) {
        biometricsAuth()
    }
    
    @IBAction func faceAuthAction(_ sender: Any) {
        biometricsAuth()
    }
    
    @IBAction func passcodeValidationAction(_ sender: Any) {
        let pass = passcodeInput.text
        if (pass?.count == 4){
            if(pass == KeychainWrapper.standard.string(forKey: "protein")){
                passcodeInput.text = ""
                performSegue(withIdentifier: "segueToProteinList", sender: nil)
            } else {
                passcodeInput.text = ""
                self.authFailedAlert()
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        passcodeInput.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _:String = KeychainWrapper.standard.string(forKey: "protein"){
            displayButtons()
        }else{
            faceIDButton.isHidden = true
            touchIDButton.isHidden = true
            passcodeInput.isHidden = true
            passCodeAlert()
        }
        // Do any additional setup after loading the view.
    }
    

}

// MARK - Biometric's Auth
extension LoginViewController{

    func biometricsAuth(){
    let context: LAContext = LAContext()
    var authError: NSError?
    if(context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError)){
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authentication is needed to access app"){success, evaluateError in
            
            if success {
                DispatchQueue.main.async{
                    self.performSegue(withIdentifier: "segueToProteinList", sender: nil)}
            } else {
                if let error = evaluateError {
                    print(error)
                    DispatchQueue.main.async {
                        self.authFailedAlert()
                    }
                }
            }
        }
    }
}
    func authFailedAlert(){
        let alert = UIAlertController(title:"Authentication Failed", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction( title:"OK", style:.default))
        self.present(alert, animated:true)
    }
}

// MARK - Register PassCode alert
extension LoginViewController{
   
    func passCodeAlert(){
        DispatchQueue.main.async {
        let alert = UIAlertController(title: "Choose a 4 numbers passcode", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: {textField in
            textField.placeholder = "Enter your passcode here..."
            textField.keyboardType = .numberPad
            textField.addTarget(alert, action: #selector(alert.textDidChangeInRegisterPasscodeAlert), for: .editingChanged)
        })
        let action = UIAlertAction(title: "OK", style: .default, handler:
        {action in
            if let pass = alert.textFields?.first?.text {
                    KeychainWrapper.standard.set(pass, forKey:"protein")
                self.displayButtons()
                print("ok")
            }
        })
        action.isEnabled = false
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        }
    }
    
    func displayButtons(){
        touchIDButton.tintColor = UIColor(named:"light_grey")
        faceIDButton.tintColor = UIColor(named: "light_grey")
        let context: LAContext = LAContext()
        let biometricType = context.biometricType
        if (biometricType == .touchID){
            faceIDButton.isHidden = true
            touchIDButton.isHidden = false
            passcodeInput.isHidden = false
        } else if (biometricType == .faceID){
            touchIDButton.isHidden = true
            faceIDButton.isHidden = false
            passcodeInput.isHidden = false
        } else {
            faceIDButton.isHidden = true
            touchIDButton.isHidden = true
            passcodeInput.isHidden = false
            switchLabel.isHidden = true
        }
    }
}


extension UIAlertController {
    
    func isValidPasscode(passcode:String) -> Bool{
        return passcode.count == 4 && passcode.range(of: "[0-9]", options: .regularExpression) != nil
        
    }
    
    @objc func textDidChangeInRegisterPasscodeAlert(){
        if let passcode = textFields?[0].text, let action = actions.first{
                action.isEnabled = isValidPasscode(passcode: passcode)
            }
        }
}

extension LAContext {
    enum BiometricType: String {
        case none
        case touchID
        case faceID
    }

    var biometricType: BiometricType {
        var error: NSError?

        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }

        if #available(iOS 11.0, *) {
            switch self.biometryType {
            case .none:
                return .none
            case .touchID:
                return .touchID
            case .faceID:
                return .faceID
            @unknown default:
                #warning("Handle new Biometric type")
            }
        }
        
        return  self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
    }
}
