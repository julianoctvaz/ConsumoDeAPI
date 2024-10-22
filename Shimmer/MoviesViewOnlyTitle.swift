//
// MoviesViewOnlyTitle.swift
//  Shimmer
//
//  Created by Juliano on 14/10/24.
//

//
import SwiftUI
import ShimmeringUiView

public struct MoviesViewOnlyTitle: View {
    
    @State private var isLoading: Bool = false
    @State private var movies: [Movie]?
    @State private var serviceError: ServiceError?
    
    public var body: some View {
        
        Button(
            //action botao
                action: {
                    isLoading = true // para iniciar o shimmer
                    MovieService().searchMovies(withTitle: "Steve Jobs") { moviesList, error in
//                            DispatchQueue.main.async { //mt rapido
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){ //sempre mudamos nossa ui dentro da thread principal
                            isLoading = false // para terminar shimmer
                            if let error = error {
                                // Trata o erro de serviço
                                serviceError = error
                                
                            } else if let moviesList = moviesList {
                                movies = moviesList //se deu tudo certo colocar dados em variavel
                            }
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
            if let error = serviceError {
                Text("Erro: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
            } else if isLoading {
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
    MoviesViewOnlyTitle()
}
