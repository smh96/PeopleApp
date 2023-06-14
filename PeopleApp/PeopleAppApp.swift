//
//  PeopleAppApp.swift
//  PeopleApp
//
//  Created by Sander Haug on 13/06/2023.
//

import SwiftUI

@main
struct PeopleAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleView()
                    .tabItem {
                        Symbols.person
                        Text("Home")
                    }
                SettingsView()
                    .tabItem {
                        Symbols.gear
                        Text("Settings")
                    }
            }
        }
    }
}
