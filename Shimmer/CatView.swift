//
//  CatView.swift
//  Shimmer
//
//  Created by Juliano on 14/10/24.
//
import SwiftUI
import ShimmeringUiView

public struct CatView: View {
    
    @State private var isLoading: Bool = false
    @State private var catFact: String?
    
    public var body: some View {
        
        Button(
            //action botao
                action: {
                    isLoading = true // para iniciar o shimmer
                        CatService.getRandomFact { cat, error in
//                            DispatchQueue.main.async { //mt rapido
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                               isLoading = false // para terminar shimmer
                               if let cat = cat {
                                   catFact = cat.data.first // assumindo que `Cat` tem uma propriedade `fact`
                               } else {
                                   catFact = "Erro ao carregar o fato"
                               }
                           }
                        }
                },
                //label botao
                label: {
                        HStack(alignment: .top, spacing: 4) {
                            Image(systemName: "cat.fill")
                            Text("Chameow a requisição")
                        }
                }
            ) // fim botao
        .buttonStyle(.borderedProminent)
        
        Divider()
        
        VStack (alignment: .leading) {
            if isLoading {
                HStack(alignment: .top, spacing: 4) {
                    Image(systemName: "cat.fill")
                    Text("""
                        Carregando... Layout.. Shimmering,
                        Carregando... Layout... Shimmering,
                        Carregando... Layout... Shimmering
                        """)
                        .multilineTextAlignment(.leading)
                }
            } else if let fact = catFact {
                HStack(alignment: .top, spacing: 4) {
                    Image(systemName: "cat.fill")
                    Text(fact)
                }
            }
        } // fim VStack
        .frame(maxWidth: 300, minHeight: 20, alignment: .leading) //alinha internamente a esquerda
        .padding()
        .background(isLoading || catFact == nil ? Color.clear : Color.green.opacity(0.1))
        .cornerRadius(8)
        .shimmering(active: isLoading)
               
   }
}

#Preview {
    CatView()
}
