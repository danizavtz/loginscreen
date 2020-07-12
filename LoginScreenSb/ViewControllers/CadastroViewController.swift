//
//  CadastroViewController.swift
//  LoginScreenSb
//
//  Created by Daniel Lucena Pires on 23/06/20.
//  Copyright © 2020 Pessoal. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputUsuario: UITextField!
    @IBOutlet weak var inputSenha: UITextField!
    @IBOutlet weak var inputConfirmar: UITextField!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnCadastrar: UIButton!
    let cadastrarUrl:String = "https://api.danizavtz.com.br/cadastro"
    let child = SpinnerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        lblError.text = ""
        inputEmail.text = ""
        inputEmail.autocorrectionType = .no
        inputSenha.text = ""
        inputSenha.autocorrectionType = .no
        inputConfirmar.text = ""
        inputConfirmar.autocorrectionType = .no
        inputUsuario.text = ""
        inputUsuario.autocorrectionType = .no
    }
    
    func validateFields() -> String? {
        if (inputEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            inputUsuario.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            inputSenha.text?.trimmingCharacters(in: .newlines) == "" ||
            inputConfirmar.text?.trimmingCharacters(in: .newlines) == "") {
            return "Preencha todos os campos"
        }
        
        return nil
    }
    
    @IBAction func cadastrarTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            lblError.text = error!
            return
        }
        let url = URL(string: cadastrarUrl)!
        let dadosCadastro: Cadastro = Cadastro(username: inputUsuario.text!, senha: inputSenha.text!, email: inputEmail.text!)
        guard let encodedCadastroData = try? JSONEncoder().encode(dadosCadastro) else {
            return
        }
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedCadastroData
        inserirSpinnerView()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    DispatchQueue.main.async {
                        self.lblError.text = "Usuário ou senha incorretos"
                    }
                    self.removerSpinnerView()
                    return
            }
            DispatchQueue.main.async {
                self.chamarTelaLogin()
            }
        }
        task.resume()
    }
    
    @IBAction func actionVoltar(_ sender: Any) {
        let inicioViewController = self.storyboard?.instantiateViewController(identifier: "initappscreen") as? ViewController
        self.view.window?.rootViewController = inicioViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func chamarTelaLogin() {
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "loginScreen") as? LoginViewController
        self.view.window?.rootViewController = loginViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func inserirSpinnerView() {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removerSpinnerView() {
           DispatchQueue.main.async {
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
           }
    }
}
