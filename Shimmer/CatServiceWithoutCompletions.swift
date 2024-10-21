import Foundation

class CatServiceWithoutCompletions {
    
    // URL da API que retorna fatos aleatórios sobre gatos, com o parâmetro de linguagem em português.
    static let url = URL(string:"https://meowfacts.herokuapp.com/?lang=por-br")
    
    // Função estática que faz uma requisição para a API e retorna um resultado assíncrono.
    // Ela usa o `Result` para encapsular o sucesso com o tipo `Cat?` ou uma falha com um `Error`.
    public static func getRandomFact() async -> Result<Cat?, Error> {
        
        // Verifica se a URL é válida. Caso contrário, retorna um erro do tipo `URLError`.
        // O `guard let` garante que a execução do código só continua se a URL estiver corretamente configurada.
        guard let url = url else {
            return .failure(URLError(.badURL)) // `URLError` é um erro nativo do Swift para URLs inválidas.
        }
        
        do {
            // Aqui começa a requisição assíncrona.
            // `URLSession.shared.data(from:)` é o método que faz a requisição HTTP e retorna os dados recebidos e a resposta da URL.
            // `try await` indica que o código pode lançar um erro e que precisa esperar a resposta da requisição.
            let (data, responseCode) = try await URLSession.shared.data(from: url)
            
            // Verifica se o código de resposta HTTP está entre 200 e 299, o que indica uma resposta bem-sucedida.
            guard let httpResponse = responseCode as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                // Se o código de status não estiver nesse intervalo, retorna um erro indicando falha de resposta do servidor.
                return .failure(URLError(.badServerResponse))
            }
            
            // Agora que temos os dados (`data`) da API, vamos tentar decodificá-los para o tipo `Cat`.
            // `JSONDecoder()` é utilizado para converter o JSON recebido em um objeto Swift.
            // `try` indica que esta linha pode lançar um erro se os dados não forem decodificáveis no tipo `Cat`.
            let cat = try JSONDecoder().decode(Cat.self, from: data)
            
            // Se a decodificação for bem-sucedida, retornamos o `cat` encapsulado no `.success`.
            return .success(cat)
            
        } catch {
            // Caso ocorra qualquer erro durante a requisição ou decodificação dos dados, ele é capturado aqui.
            // O erro é retornado no `.failure`, permitindo que a função chamadora lide com ele de forma apropriada.
            print(error.localizedDescription) // Para fins de depuração, imprime o erro no console.
            return .failure(error) // Retorna o erro capturado.
        }
    }
}
