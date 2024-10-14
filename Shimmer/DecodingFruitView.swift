//
//  DecodingFruitView.swift
//  Shimmer
//
//  Created by Juliano on 14/10/24.
//

import SwiftUI
import ShimmeringUiView

struct DecodingFruitView: View {
    // MARK: - Properties
    
    let decoder = JSONDecoder()
    @State var product: Product?
    @State var isLoading: Bool = true
    
    
    // MARK: - UI
    
    var body: some View {
        
        Button(action: {
            requestData()
        }, label: {
            Text("Toque para decodificar")
        })
        
        Divider()
        
        if let product = product {
            VStack {
                if let name = product.name { Text(name) }
                if let points = product.points { Text(String(points)) }
                if let description = product.description { Text(description) }
            }
            .shimmering(active: isLoading)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    isLoading.toggle()
                })
            }
        }
    }
    
    // MARK: - Functions
    
    fileprivate func requestData() {
        do {
            product = try decoder.decode(Product.self, from: json)
            if let product = product {
                if let name = product.name { print(name) }
                if let points = product.points { print(points) }
                if let description = product.description { print(description) }
            }
        } catch {
            print("Não consegui decodificar e o erro foi " + error.localizedDescription)
        }
    }
}

// MARK: - Preview

#Preview {
    DecodingFruitView()
}