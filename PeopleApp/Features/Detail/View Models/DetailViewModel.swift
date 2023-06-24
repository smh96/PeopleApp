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
    
    func fetchDetails(for id: Int) {
        isLoading = true
        NetworkingManager.shared.request("https://reqres.in/api/users/\(id)?delay=3",
                                         type: UserDetailResponse.self) { [weak self] res in
            
            DispatchQueue.main.async {
                defer { self?.isLoading = false}
                switch res {
                case .success(let response):
                    self?.userInfo = response
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
            }
        }
    }
}
