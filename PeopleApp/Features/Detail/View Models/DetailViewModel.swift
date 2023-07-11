//
//  DetailViewModel.swift
//  PeopleApp
//
//  Created by Sander Haug on 20/06/2023.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserDetailResponse?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    @Published var isLoading = false
    
    @MainActor
    func fetchDetails(for id: Int) async {
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            self.userInfo = try await NetworkingManager.shared.request(.detail(id: id), type: UserDetailResponse.self)
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}
