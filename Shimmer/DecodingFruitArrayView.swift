//
//  DecodingFruitArrayView.swift
//  Shimmer
//
//  Created by Juliano on 03/10/24.
//

import SwiftUI
import ShimmeringUiView

struct DecodingFruitArrayView: View {
    // MARK: - Properties
    
    let decoder = JSONDecoder()
    
    @State var products: [Product?]?
    @State var isLoading: Bool = true
    
    // MARK: - UI
    
    var body: some View {
        
        Button(action: {
            requestData()
        }, label: {
            Text("Toque para decodificar")
        })
        
        Divider()
        
        if let products = products {
            
            ForEach(products, id: \.self) { product in
                
                if let product = product, hasValidProperties(product) {
                    VStack(alignment: .leading) { // ALINHA OS ELEMENTOS A ESQUERDA
                        if let name = product.name {  Text(name).bold() }
                        if let points = product.points { Text(String(points)) }
                        if let description = product.description { Text(description) }
                    }
                    .frame(maxWidth: 210, alignment: .leading) //alinha internamente a esquerda
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
                    
                } else {
                    ProducUnknownView()
                }
            } // para cada elemento do foreach
            .shimmering(active: isLoading) // lib externa (3rd party code)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    isLoading.toggle()
                })
            }
            // fim Vstack de produto
        }
    }
    
    struct ProducUnknownView: View {
        var body: some View {
            Text("Product is unknown (nil)")
                .frame(width: 210)
                .italic()
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
        }
    }
    
    // MARK: - Functions
    
    fileprivate func requestData() {
        do {
            
            // Verifique se o Data está vazio  "" //1
            if jsonArray.isEmpty {
                print("JSON está vazio")
                // ""
                return
            }
            
            //verifica se tem algum objeto vazio  (elemento) //2
            if let jsonRecebido = try JSONSerialization.jsonObject(with: jsonArray) as? [[String: Any]] {
                // Verifica se o array está vazio ou se contém objetos vazios
                if jsonRecebido.isEmpty {
                    print("JSON contém um array vazio")
                    // []
                    return
                    
                } else if jsonRecebido.allSatisfy({ $0.isEmpty }) {
                    print("JSON contém somente objeto(s) vazio(s) dentro do array")
                    // [{}] ou [{}, {}] ou [{}, {}, {}] ...
                    return
                }
            }
            
            products = try decoder.decode([Product].self, from: jsonArrayWithEmptyValues)
            
            if let products = products {
                
                for product in products {
                    print("-----------------------------")
                    
                    if let name = product?.name { print(name) }
                    if let points = product?.points { print(points) }
                    if let description = product?.description { print(description) }
                    
                    //caso queiramos exibir uma mensagem padrao podemos desempacotar assimnil coalescing
                    //print(product?.name ?? "No name")
                    //print(product?.points ?? "666")
                    //print(product?.description ?? "No description")
                }
            }
        } catch {
            print("Não consegui decodificar e o erro foi " + error.localizedDescription)
            if let jsonString = String(data: jsonArrayWithEmptyValues, encoding: .utf8) {
                print("JSON recebido: \(jsonString)")
            }
        } // fim catch
    }
    
    private func hasValidProperties(_ product: Product?) -> Bool {
        guard let product = product else { return false }
        return product.name != nil || product.points != nil || product.description != nil
    }
}


// MARK: - Preview

#Preview {
    DecodingFruitArrayView()
}
