//
//  ResponseData.swift
//  APIWorking2
//
//  Created by Aatish Mehta on 12/22/23.
//

import Foundation

struct ResponseData: Codable {
    let firstName: String
    let lastName: String
    let userName: String
    let passwordProperty: String
    let confirmPasswordProperty: String

    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case userName
        case passwordProperty = "password"
        case confirmPasswordProperty = "confirmPassword"
    }
}
