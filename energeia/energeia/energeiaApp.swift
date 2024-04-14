//
//  energeiaApp.swift
//  energeia
//
//  Created by Prannvat Singh on 13/04/2024.
//

import SwiftUI

@main
struct EnergeiaApp: App {
    @State private var showMainTabView = false

    var body: some Scene {
        WindowGroup {
            if showMainTabView {
                MainTabView()
                    .preferredColorScheme(.light)
            } else {
                ContentView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showMainTabView = true
                        }
                    }
                    .preferredColorScheme(.light)
            }
        }
    }
}
