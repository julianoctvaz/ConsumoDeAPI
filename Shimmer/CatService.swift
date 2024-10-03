//
//  CatService.swift
//  Shimmer
//
//  Created by Juliano on 03/10/24.
//
import Foundation

enum Error: Swift.Error {
    case invalidResponse
    case invalidData
    case invalidURL
    // colocar textos
}

class CatService {
    static let url = URL(string:"https://meowfacts.herokuapp.com/?lang=por-br")
    
    public static func getRandomFact(completion: (String?, Error?) -> Void) {
//        public static func getRandomFact(completion: (String?, Error?) -> Void) { ainda mostrando sem o escaping
//        1) verifica url
        guard let url else {
            completion("URL não encontrada", .invalidURL)
            return
        }
        
//        2) cria requisicao
        let request = URLRequest(url: url)
        
//        tipo de resposta que teremos, usando a closure, mas podem fazer uso da trailling closure e colocar o a completion dentro do bloco de codigo {}
//        URLSession.shared.dataTask(with: url, completionHandler: <#T##(Data?, URLResponse?, (any Error)?) -> Void#>)
        
//        completionHandler é algo que vai ser chamado assim que a requisição for retornada
        
//        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // a response vem com algumas informacoes como os codigos de identificacao do http na comunicacao 400, 400, 500
//            guard let data else {
//                completion("Dados inválidos", .invalidData)
//                return
//            }
//            uma vez que tenha esse dados, vamos tentar fazer uma transformacao do dado para algum tipo nativo ou que tenhamos criado com o:
//            JSONDecoder().decode(String.self, from: data)
//            { result in
//                
//            }
            
//            mas como esse JSONDecoder
            
//            guard error == nil else {
//                completion("Resposta da requisição inválida", .invalidResponse)
//                return
//            }
//        }
    }
    //chama esse codigo assim que a requisicao for completada
//    enum Result {
//        case success([Cat])
//        case failure(Swift.Error)
//    }
    
    

}
