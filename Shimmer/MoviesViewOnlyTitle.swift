//
// MoviesView.swift
//  Shimmer
//
//  Created by Juliano on 14/10/24.
//

//
import SwiftUI
import ShimmeringUiView

public struct MoviesView: View {
    
    @State private var isLoading: Bool = false
    @State private var movies: [Movie]?
    
    public var body: some View {
        
        Button(
            //action botao
                action: {
                    isLoading = true // para iniciar o shimmer
                    MovieService().searchMovies(withTitle: "Steve Jobs") { moviesList in
//                            DispatchQueue.main.async { //mt rapido
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2){ //sempre mudamos nossa ui dentro da thread principal
                               isLoading = false // para terminar shimmer
//                               if let moviesList = moviesList { nao tem como dar erro!!!
                                movies = moviesList
//                               }
//                                   else {
//                                   print(error?.localizedDescription ?? "Erro ao carregar o fato")
//                               }
                           }
                        }

                },
                //label botao
                label: {
                        HStack(alignment: .top, spacing: 4) {
                            Image(systemName: "film.fill")
                            Text("Chameow a requisição")
                        }
                }
            ) // fim botao
        .buttonStyle(.borderedProminent)
        
        Divider()
        
        VStack (alignment: .leading) {
            if isLoading {
                HStack(alignment: .top, spacing: 4) {
                    //                    Image(systemName: "cat.fill")
                    //arrumar layout shimmer
                    Text("""
                        Carregando... Layout.. Shimmering,
                        Carregando... Layout.. Shimmering,
                        Carregando... Layout.. Shimmering,
                        """)
                    
                }
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: 210, alignment: .leading)
                        .padding()
                
            } else if let movies = movies {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(movies, id: \.self) { movie in
                        VStack() {
                            Text(movie.title)
                        }
                        .frame(maxWidth: 210, alignment: .leading) //alinha internamente a esquerda
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    
                }
            }
        } // fim VStack
        
        .shimmering(active: isLoading)
               
   }
}

#Preview {
    MoviesView()
}
