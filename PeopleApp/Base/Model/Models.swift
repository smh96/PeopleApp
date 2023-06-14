//
//  Models.swift
//  PeopleApp
//
//  Created by Sander Haug on 14/06/2023.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

}

// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}
