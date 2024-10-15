//
//  CatService.swift
//  Shimmer
//
//  Created by Juliano on 03/10/24.
//
import Foundation

class CatService {
//    https://github.com/wh-iterabb-it/meowfacts
//    vamos pegar fatos aleatorios sobre gatos primeiro
    
    static let url = URL(string:"https://meowfacts.herokuapp.com/?lang=por-br")
    
//    vamos criar uma variavel estatica facilitar para nos ajudar a fazer a requisicao //1
     
//    vamos criar tb uma funcao estatica que retorna um fato aleatorio, por isso que é um get,
//    public static func getRandomFact() //2
    
//    e queremos chamar ela extamente quando a funcao for completada, ela nao vai nos devolver o resultado logo de cara! (explicar melhor isso)
//    estamos implementando uma técnica chamada callback em desenvolvimento web, mas para gente no swift mais conhecido como uma closure, essa closure esta como paramentro da nossa funcao,  Essa closure será chamada apenas quando a operação for finalizada, com sucesso ou com erro.
//   Precisamos dela para lidar com operações que podem levar tempo, como buscar dados de uma API, ler um arquivo, ou qualquer outra tarefa assíncrona.
//    Ou seja, pode ser que estamos querendo fazer uma operação que demora um pouco, e chamá-la diretamente (de forma síncrona) iria "travar" o programa enquanto esperamos a resposta. por isso devemos usar closure aqui
    
//    public static func getRandomFact(completion: (String?, Error?) -> Void) { // manter essa primeiro...
    
//    public static func getRandomFact(completion: (Cat?, Error?) -> Void) { // depois vai virar essa.. segundo...
        
    public static func getRandomFact(completion: @escaping (Cat?, Error?) -> Void) { // depois vai virar essa.. terceiro ao chegar no ponto 4 mais pro fim...
        
        //como ja falamos anterior, sempre que tivermos tratando de consumo de API, de requisicao, vamos ter que tratar o caso de sucesso e o caso de falha (o caso de erro), por isso que vamos manter nossa completion assim pois podemos receber um dos dois cenários. A internet tem sua propria forma de ser ✨
        
        
        
        
        /*  //3
         
         
        // Digamos que aqui fazemos uma chamada de rede que leva tempo
        // Depois que a chamada de rede termina, chamamos 'completion' com os dados:
        completion("Fato interessante: Gatos são fofos!", nil)  // caso de sucesso
        // ou
        completion(nil, error)  // caso de erro
         
        }
         
         
         // Quando getRandomFact é chamada, o programa não fica esperando o retorno; ele continua executando outras instruções enquanto a função trabalha em segundo plano. Ao final, a closure completion é chamada, entregando o resultado ou o erro.
        */
        
        
        
        
          //4
         
    
//         verifica url, precisamos garantir que nossa ufpe esta em perfeito estado!
        guard let url else { return }
         
          
        
         //parar criar a nossa requisicao, vamos usar uma classe chamda URLSession, acessar a variavel compartilhada dela que nos permite chamar atividades de busca de dados.
        
//        tipo de resposta que teremos dada a nossa url e o completionHandler que vai ser chamado assim que chegar os nossos dados, ou seja, assim que a funcao for retornada  mas podem fazer uso da trailling closure e colocar o a completion dentro do bloco de codigo {}
//        URLSession.shared.dataTask(with: url, completionHandler: <#T##(Data?, URLResponse?, (any Error)?) -> Void#>)
        
//        completionHandler é algo que vai ser chamado assim que a requisição for retornada
        // teremos entao o nosso Data -> dados, e tambem a URL reponse a response vem com algumas informacoes como os codigos de identificacao do http na comunicacao 400, 400, 500, bem como algum erro
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            //precisamos garantir que nos vamo ter ter algum dado senao podemos sair do nosso processo:
            guard let data else { return }
            
//            NEssa etapa nos estamos com o dado agora no formato do nosso banco! entao a partir de agora vamos usar o nosso decoder! podemos criar ele como uma variavel ou chamar diretamente assim:
            
//            uma vez que tenha esse dados, vamos tentar fazer uma transformacao do dado para algum tipo nativo ou que tenhamos criado com o:
                // JSONDecoder().decode(String.self, from: data) // novamente! precisamos usar o try... do-catch...
//
            do {
                let result = try JSONDecoder().decode(Cat.self, from: data) // ai vamos alterar a assinatura da nossa funcao tambem de String para Cat
                // se tudo deu certo a gente vai assim que chegar o dado devolver para quem nos chamar o resultado.. #primeiro
                completion(result, nil) // #segundo
//                Em Swift, closures são, por padrão, não-escaping, ou seja, elas precisam ser executadas antes que a função que as recebe retorne.
//                O compilador exige que a completion seja marcada como @escaping porque ela é usada dentro de uma closure que será executada mais tarde, fora do escopo original da função getRandomFact ou seja nao vamos já usar esse ja de cara, vamos so manter ele quentinho, gostosinho para usar depois
//No caso de operações assíncronas, como chamadas de rede, a closure completion não será chamada imediatamente; ela só será chamada quando a tarefa assíncrona terminar.
//                a execução de completion ocorre após getRandomFact retornar. Isso significa que a completion precisa escapar do escopo da função para ser usada mais tarde.
//                Quando uma closure é marcada como @escaping, ela indica que será mantida viva e chamada depois que a função que a recebeu já terminou.
//                É como se mantivessemos uma parte da funcao ainda viva, armazenada em outro lugar do nosso codigo, que so vamos liberar quando quisermos, por isso que ela tem escapar da funcao atual, a getRandomFact
            } catch {
                //ou vamos devolver o erro
                print(error.localizedDescription)
                //ainda vamos fazer mais tratamentos de erros! por enquanto vamos so garantir que estamos pegando o dado corretamente
                completion(nil, error)
                
            }
            
//            mas o nosso tipo de dado da API é do tipo String? Vamos ver!
            
//            Não né, entao lembra de Product? Vamos ter que criar um modelo para esse tipo de dado!

        }
        .resume()
        //Ao chamar .resume(), você inicia efetivamente a tarefa, disparando a requisição para o servidor e permitindo que o completionHandler seja executado quando a resposta for recebida.
    }
    
    
    
    //chama esse codigo assim que a requisicao for completada
//    enum Result {
//        case success([Cat])
//        case failure(Swift.Error)
//    }
    
    

}
