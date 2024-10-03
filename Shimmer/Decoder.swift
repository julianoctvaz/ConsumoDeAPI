//
//  Decoder.swift
//  Shimmer
//
//  Created by Juliano on 03/10/24.
//

import Foundation
import SwiftUI
import ShimmeringUiView

struct GroceryProduct: Codable {
    // o que é esse protocolo codable
    //    qual a diferenca para o decodable
    var name: String
    //essas propriedade devem ser opcionais?
    var points: Int
    var description: String
}

let json = """
{
    "name": "Durian",
    "points": 600,
    "description": "A fruit with a distinctive scent."
}
""".data(using: .utf8)!

let jsonArray = """

{
    {
        "name": "Durian",
        "points": 600,
        "description": "A fruit with a distinctive scent."
    },
    {
        "name": "Durian2",
        "points": 602,
        "description": "A2 fruit2 with2 a2 distinctive2 scent2."
    }
}
""".data(using: .utf8)!


struct DecoderTest: View {
    
    
    let decoder = JSONDecoder()
    @State var product: GroceryProduct?
    @State var products: [GroceryProduct?] = []
    @State var isLoading: Bool = true
    
    var body: some View {
        
        //        HStack {
        //            Button(action: {
        //                let product = try decoder.decode(GroceryProduct.self, from: json) // mas precisamos tentar capturar o erro que esta dando
        //                print(product.name) // Prints "Durian"
        //            }, label: {
        //                Text("Toque para decodificar")
        //            })
        //        }
        
        VStack {
            Button(action: {
                do {
                    product = try decoder.decode(GroceryProduct.self, from: json) // mas precisamos tentar capturar o erro que esta dando
                    // mas o que é o try
                    if let product = product {
                        print(product.name)
                        print(product.points)
                        print(product.description)
                    }
                } catch {
                    print("Não consegui decodificar e o erro foi" + error.localizedDescription)
                }
            }, label: {
                Text("Toque para decodificar")
            })
            
            Divider()
            
            if let product = product {
                VStack {
                    Text(product.name)
                    Text(String(product.points))
                    Text(product.description)
                }
                .shimmering(active: isLoading)
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        isLoading.toggle()
                    })
                }
            }
        }
    }
}

#Preview {
    DecoderTest()
}


