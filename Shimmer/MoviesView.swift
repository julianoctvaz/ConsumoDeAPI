//
//  MoviesView.swift
//  Shimmer
//
//  Created by Juliano on 15/10/24.
//

import SwiftUI
import ShimmeringUiView

public struct MoviesView2: View {
    
    @State private var isLoading: Bool = false
    @State private var movies: [Movie]?
    @State private var imagesOfMovies: [Data?] = [] // Array para armazenar os dados das imagens dos filmes
    @State private var serviceError: ServiceError? 
    
    public var body: some View {
        
        Button(
            action: {
                requestData()
            },
            label: {
                HStack(alignment: .top, spacing: 4) {
                    Image(systemName: "film.fill")
                    Text("Chameow a requisição")
                }
                .padding() // Adicionar um padding para que o conteúdo tenha espaço interno
                .background(Color(red: 0.447, green: 0.184, blue: 0.216))
                .foregroundStyle(.white)
                .cornerRadius(10)
            }
        ) // fim botao
        
        Divider()
        
        VStack(alignment: .leading) {
            if let error = serviceError {
                Text("Erro: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
            } else if isLoading {
                HStack(alignment: .top, spacing: 4) {
                    Image(systemName: "photo") // Placeholder enquanto a imagem carrega
                        .resizable()
                        .frame(width: 50, height: 75)
                        .foregroundColor(.gray)
                        .cornerRadius(4)
                    
                    Text("""
                        Carregando... Layout.. Shimmering,
                        """)
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 250, alignment: .leading)
                .padding()
                
            } else if let movies = movies {
                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        ForEach(movies.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 4) {
                                if let imageData = imagesOfMovies[index], let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .frame(width: 50, height: 75) // ajuste de tamanho conforme necessário
                                        .cornerRadius(4)
                                } else {
                                    Image(systemName: "photo") // Placeholder enquanto a imagem carrega
                                        .resizable()
                                        .frame(width: 50, height: 75)
                                        .foregroundColor(.gray)
                                        .cornerRadius(4)
                                }
                                Text(movies[index].title)
                            }
                            .frame(maxWidth: 250, alignment: .leading)
                            .padding()
                            .background(Color(red: 0.447, green: 0.184, blue: 0.216).opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                }
            }
        } // fim VStac3k
        .shimmering(active: isLoading)
    }
    
    private func requestData() {
        isLoading = true // Inicia o shimmer
        
        // Busca filmes
        MovieService().searchMovies(withTitle: "Michael Jackson") { moviesList, error in
            // Aguarda o delay para o shimmer
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false // Finaliza o shimmer
                
                if let error = error {
                    // Trata o erro de serviço
                    serviceError = error
                } else if let moviesList = moviesList {
                    // Atualiza os filmes e inicia o array de imagens
                    movies = moviesList
                    imagesOfMovies = Array(repeating: nil, count: moviesList.count)
                    
                    // Carrega as imagens para cada filme
                    for (index, movie) in moviesList.enumerated() {
                        if let posterURL = movie.posterURL {
                            // Carrega a imagem
                            MovieService().loadImageData(fromURL: posterURL) { imageData, imageError in
                                
                                if let imageError = imageError {
                                    // Trata o erro de imagem
                                    serviceError = imageError
                                } else if let imageData = imageData {
                                    // Atualiza a imagem no array
                                    DispatchQueue.main.async {
                                        if index < imagesOfMovies.count {
                                            imagesOfMovies[index] = imageData
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MoviesView2()
}

