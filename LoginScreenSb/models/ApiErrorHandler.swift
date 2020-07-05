//
//  ApiErrorHandler.swift
//  LoginScreenSb
//
//  Created by Daniel Lucena Pires on 04/07/20.
//  Copyright © 2020 Pessoal. All rights reserved.
//

import Foundation

struct ApiErrorHandler : Codable {
    let location : String
    let msg : String
    let param: String
}
