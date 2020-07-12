//
//  SuccessController.swift
//  LoginScreenSb
//
//  Created by Daniel Lucena Pires on 12/07/20.
//  Copyright © 2020 Pessoal. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chamarTelaInicial()
    }
    
    func chamarTelaInicial() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
           let inicioViewController = self.storyboard?.instantiateViewController(identifier: "initappscreen") as? ViewController
           self.view.window?.rootViewController = inicioViewController
           self.view.window?.makeKeyAndVisible()
        }
    }
}
