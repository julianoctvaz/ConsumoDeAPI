//
//  ContentView.swift
//  Shimmer
//
//  Created by Juliano on 02/10/24.
//

import SwiftUI
import ShimmeringUiView

struct ContentView: View {
    
    @State var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            Color.clear
            HStack {
                Image("burnoutinho")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Text("Hello")
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
