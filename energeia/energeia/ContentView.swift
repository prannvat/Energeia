//
//  ContentView.swift
//  energeia
//
//  Created by Prannvat Singh on 13/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showLogo: Bool = false
    var body: some View {
        VStack {
            Spacer()
            if showLogo{
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.tint)
                    .shadow(radius: 40)
            }
            Spacer()
        }
        .onAppear{
            withAnimation(.interactiveSpring(duration: 1.2)){
                showLogo = true
            }
        }
        
    
    }
}

#Preview {
    ContentView()
}
