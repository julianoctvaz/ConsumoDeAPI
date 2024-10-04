//
//  Error.swift
//  Shimmer
//
//  Created by Juliano on 03/10/24.
//

//The data couldn’t be read because it isn’t in the correct format.

//
//Para resolver o problema, sugiro que:
//
//Verifique se o JSON tem o formato e as chaves corretas.
//Assegure-se de que os tipos de dados no JSON sejam compatíveis com os tipos das propriedades na struct.
//Adicione CodingKeys caso as chaves no JSON sejam diferentes.


enum ServiceError: Error {
    case networkError(String)    
    case decodingError(String)
    case invalidResponse(String)
    case invalidData(String)
    case invalidURL(String)
    case unknownError
    //N ão seria apropriado usar @unknown default diretamente aqui nesse enem pq o atributo @unknown default é usado exclusivamente em um switch statement para tratar de casos futuros desconhecidos em enums, não dentro da definição do enum
    
    //Não está sendo usado
    var description: String {
        switch self {
        case .networkError(let message):
            return "Network error: \(message)"
        case .decodingError(let message):
            return "Decoding error: \(message)"
        case .invalidResponse(let message):
            return "Invalid response: \(message)"
        case .invalidData(let message):
            return "Invalid data: \(message)"
        case .invalidURL(let message):
            return "Invalid URL: \(message)"
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

