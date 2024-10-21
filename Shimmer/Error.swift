//
//  Error.swift
//  Shimmer
//
//  Created by Juliano on 03/10/24.
//

import Foundation

// Ao inves do protocolo Error, podemos criar nosso proprio enum que trata os cenarios de erro!

//
//Para resolver o problema, sugiro que:
//
//Verifique se o JSON tem o formato e as chaves corretas.
//Assegure-se de que os tipos de dados no JSON sejam compatíveis com os tipos das propriedades na struct.
//Adicione CodingKeys caso as chaves no JSON sejam diferentes.


enum ServiceError: Error {
    case networkError
    case decodingError
    case invalidResponse
    case invalidData
    case noData
    case invalidURL
    case unknownError
    //N ão seria apropriado usar @unknown default diretamente aqui nesse enem pq o atributo @unknown default é usado exclusivamente em um switch statement para tratar de casos futuros desconhecidos em enums, não dentro da definição do enum
    
    //Não está sendo usado
    var description: String {
        switch self {
        case .networkError:
            return "Network error!"
        case .decodingError:
            return "Decoding error"
        case .invalidResponse:
            return "Invalid response"
        case .invalidData:
            return "Invalid data"
        case .noData:
            return "No data"
        case .invalidURL:
            return "Invalid URL"
        case .unknownError:
            return "Unknown error occurred"
        }
    }
    
    static func mapDecodingError(_ error: DecodingError) -> String {
        switch error {
        case .typeMismatch(let type, let context):
            return "Type '\(type)' mismatch: \(context.debugDescription)"
        case .valueNotFound(let type, let context):
            return "Value not found for type '\(type)': \(context.debugDescription)"
        case .keyNotFound(let key, let context):
            return "Missing key '\(key.stringValue)': \(context.debugDescription)"
        case .dataCorrupted(let context):
            return "Data corrupted: \(context.debugDescription)"
        @unknown default:
            // Eu espero que novos casos possam ser adicionados a esse enum no futuro, e se isso acontecer, quero ser notificado no momento da compilação.
            // O @unknown foi introduzido porque o comportamento padrão de default não gera nenhum warning quando novos casos são adicionados ao enum.
            return "Unknown decoding error"
        }
    }

}

//do {
//    // Código que pode gerar um erro
//    try someThrowingFunction()
//} catch let error as URLError {
//    print("URLError occurred: \(error)")
//} catch let error as DecodingError {
//    print("DecodingError occurred: \(error)")
//} catch let error as NSError {
//    // Para capturar erros genéricos no estilo NSError (Objective-C)
//    print("NSError occurred: \(error.localizedDescription) (\(error.code))")
//} catch {
//    // Para capturar erros desconhecidos
//    print("An unknown error occurred: \(error.localizedDescription)")
//}


//let result: Result<Data, Error> = someFunctionReturningResult()
//
//switch result {
//case .success(let data):
//    print("Data received: \(data)")
//case .failure(let error):
//    if let urlError = error as? URLError {
//        print("URLError occurred: \(urlError)")
//    } else if let decodingError = error as? DecodingError {
//        print("DecodingError occurred: \(decodingError)")
//    } else if let nsError = error as? NSError {
//        print("NSError occurred: \(nsError.localizedDescription) (\(nsError.code))")
//    } else {
//        // Tratamento para erro desconhecido
//        print("An unknown error occurred: \(error.localizedDescription)")
//    }
//}


//enum APIError: Error {
//    case badRequest    // 400
//    case unauthorized  // 401
//    case forbidden     // 403
//    case notFound      // 404
//    case serverError   // 500
//    case unknown       // Undefined error
//
//    init(statusCode: Int) {
//        switch statusCode {
//        case 400: self = .badRequest
//        case 401: self = .unauthorized
//        case 403: self = .forbidden
//        case 404: self = .notFound
//        case 500: self = .serverError
//        default: self = .unknown
//        }
//    }
//}
// Em Swift, try é usado para chamadas de funções que podem lançar erros
