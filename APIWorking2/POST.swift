//
//  POST.swift
//  APIWorking2
//
//  Created by Aatish Mehta on 12/22/23.
//


import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int?
    let title: String
    let body: String
    let firstName: String
    let lastName: String
    let userName: String
    let password: String
    let confirmPassword: String

    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
        case firstName
        case lastName
        case userName
        case password
        case confirmPassword
    }
}
