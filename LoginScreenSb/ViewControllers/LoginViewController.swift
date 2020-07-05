//
//  LoginViewController.swift
//  LoginScreenSb
//
//  Created by Daniel Lucena Pires on 23/06/20.
//  Copyright © 2020 Pessoal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var textinputlogin: UITextField!
    @IBOutlet weak var textinputsenha: UITextField!
    @IBOutlet weak var buttonlogar: UIButton!
    @IBOutlet weak var buttoncancelar: UIButton!
    @IBOutlet weak var lblerror: UILabel!
    let loginUrl:String =  "https://api.danizavtz.com.br/login"
    override func viewDidLoad() {
        super.viewDidLoad()
        iniciarElementos()
        // Do any additional setup after loading the view.
    }
    
    func iniciarElementos(){
        lblerror.text = ""
        textinputlogin.text = ""
        textinputlogin.autocorrectionType = .no
        textinputsenha.text = ""
        textinputsenha.autocorrectionType = .no
        
    }
    
    func validateFields() -> String? {
        if textinputlogin.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           textinputsenha.text?.trimmingCharacters(in: .newlines) == "" {
            return "Preencha todos os campos"
        }
        
        return nil
    }
    
    @IBAction func logginTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            lblerror.text = error!
        } else {
            let url = URL(string: loginUrl)!
            let dadosAcesso: Credencial = Credencial(login: textinputlogin.text!, senha: textinputsenha.text!)
            guard let encodedAccessData = try? JSONEncoder().encode(dadosAcesso) else {
                return
            }
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = encodedAccessData
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print ("error: \(error)")
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
                }
                if let mimeType = response.mimeType,
                    mimeType == "application/json",
                    let data = data {
                      do {
                        let tkn = try JSONDecoder().decode(AuthenticationToken.self, from: data)
                        let defaults = UserDefaults.standard
                        defaults.set(tkn.token, forKey: "token")
                        DispatchQueue.main.async {
                            self.acaoMudarDeTela()
                        }
                        print ("\(tkn)")
                    } catch {
                        print("Unexpected error: \(error).")
                    }
                }
            }
            task.resume()
        }
    }
    
    @IBAction func actionGoBack(_ sender: Any) {
        let inicioViewController =  self.storyboard?.instantiateViewController(identifier: "initappscreen") as? ViewController
        self.view.window?.rootViewController = inicioViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func acaoMudarDeTela() {
        let homeViewController = self.storyboard?.instantiateViewController(identifier: "home") as? HomeViewController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }

}
