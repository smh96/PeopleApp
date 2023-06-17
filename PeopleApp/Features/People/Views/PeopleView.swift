//
//  PeopleView.swift
//  PeopleApp
//
//  Created by Sander Haug on 14/06/2023.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    @State private var users: [User] = []
    @State private var showCreate = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                background
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(users, id: \.id) { user in
                            NavigationLink {
                                DetailView()
                            } label: {
                                PersonItemView(user: user)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .onAppear {
                
                NetworkingManager.shared.request("https://reqres.in/api/users",
                                                 type: UsersResponse.self) { res in
                    switch res {
                    case .success(let response):
                        users = response.data
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            .sheet(isPresented: $showCreate) {
                CreateView()
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}

/*
    If items on your view are specific to the view, consider moving them out of the main block and isolate them below within a computed property.
 */
private extension PeopleView {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var create: some View {
        Button {
            showCreate.toggle()
            
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
}
