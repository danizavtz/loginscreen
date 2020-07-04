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
    override func viewDidLoad() {
        super.viewDidLoad()
        iniciarElementos()
        // Do any additional setup after loading the view.
    }
    
    func iniciarElementos(){
        lblerror.text = ""
        textinputlogin.text = ""
        textinputlogin.text = ""
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
        }
    }
    
    @IBAction func actionGoBack(_ sender: Any) {
        let inicioViewController =  self.storyboard?.instantiateViewController(identifier: "initappscreen") as? ViewController
        self.view.window?.rootViewController = inicioViewController
        self.view.window?.makeKeyAndVisible()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
