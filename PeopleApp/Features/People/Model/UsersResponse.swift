//
//  UsersResponse.swift
//  PeopleApp
//
//  Created by Sander Haug on 14/06/2023.
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
    
}

