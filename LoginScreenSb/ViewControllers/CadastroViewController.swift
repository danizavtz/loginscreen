//
//  CadastroViewController.swift
//  LoginScreenSb
//
//  Created by Daniel Lucena Pires on 23/06/20.
//  Copyright © 2020 Pessoal. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func actionVoltar(_ sender: Any) {
        
        let inicioViewController = self.storyboard?.instantiateViewController(identifier: "initappscreen") as? ViewController
        self.view.window?.rootViewController = inicioViewController
        self.view.window?.makeKeyAndVisible()
    }
    
}
