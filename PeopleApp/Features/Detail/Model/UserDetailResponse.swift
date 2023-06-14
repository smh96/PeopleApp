//
//  UserDetailResponse.swift
//  PeopleApp
//
//  Created by Sander Haug on 14/06/2023.
//

import Foundation

// MARK: - UserDetailResponse
struct UserDetailResponse: Codable {
    let data: User
    let support: Support
}
