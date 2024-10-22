//
//  ContentView.swift
//  Shimmer
//
//  Created by Juliano on 02/10/24.
//
// Também chamado de Skeleton

import SwiftUI
import ShimmeringUiView

struct ContentView: View {
    
    @State var isLoading: Bool = true
    
    public var body: some View {
        ZStack {
            Color.clear
            HStack {
                Image("burnoutinho")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Text("burnoutinho não é seu amiguinho!")
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .fontWidth(.expanded)
                    .padding()
            }
            .shimmering(active: isLoading)
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
            
            }
        }
    }
}

#Preview {
    ContentView()
}
