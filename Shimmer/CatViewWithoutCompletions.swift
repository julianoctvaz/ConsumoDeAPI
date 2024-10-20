import SwiftUI
import ShimmeringUiView

public struct CatViewWithoutCompletions: View {
    
    // @State cria variáveis que a view pode observar e atualizar automaticamente quando mudam
    @State private var isLoading: Bool = false // Controla se o Shimmer (efeito de carregamento) está ativo ou não
    @State private var catFact: String? // Armazena o fato sobre gatos retornado pela API
    
    public var body: some View {
        
        // Criação de um botão para realizar a requisição
        Button(
            action: {
                isLoading = true // Ativa o efeito de shimmer, simulando o carregamento de dados
                
                // Usamos o Task para lidar com operações assíncronas em SwiftUI
                Task {
                    // Aqui estamos chamando a função assíncrona `getRandomFact()`, que faz uma requisição de rede.
                    // O `await` indica que o código deve "esperar" até que a função termine antes de continuar.
                    let result = await CatServiceWithoutCompletions.getRandomFact()
                    
                    // Utilizamos `DispatchQueue.main.asyncAfter` para adicionar um atraso de 2 segundos e garantir que a mudança de estado na UI ocorra na thread principal (interface gráfica).
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoading = false // Finaliza o shimmer após a resposta
                        
                        // O `Result` é uma enum que lida com dois possíveis resultados de uma operação: sucesso ou falha.
                        // Usamos um `switch` para tratar ambos os casos.
                        switch result {
                        case .success(let cat): // Se a operação for bem-sucedida
                            // `cat?.data.first` acessa o primeiro fato sobre o gato retornado pela API.
                            catFact = cat?.data.first
                        case .failure(let error): // Se houver um erro durante a requisição
                            // Exibe o erro no console para depuração
                            print(error.localizedDescription)
                        }
                    }
                }
            },
            label: {
                // Esta é a aparência do botão que será exibido na tela
                HStack(alignment: .top, spacing: 4) {
                    Image(systemName: "cat.fill") // Ícone de gato
                    Text("Chameow a requisição") // Texto do botão
                }
            }
        ) // fim do botão
        .buttonStyle(.borderedProminent) // Define o estilo do botão como destacado
        
        Divider() // Adiciona uma linha divisória visual
        
        // Um VStack organiza as views verticalmente
        VStack(alignment: .leading) {
            // Caso o shimmer (efeito de carregamento) esteja ativo
            if isLoading {
                // Exibe uma mensagem de "carregando" com efeito de shimmer
                HStack(alignment: .top, spacing: 4) {
                    Image(systemName: "cat.fill")
                    Text("""
                        Carregando... Layout.. Shimmering,
                        Carregando... Layout... Shimmering,
                        Carregando... Layout... Shimmering
                        """)
                        .multilineTextAlignment(.leading)
                }
            // Caso o fato sobre o gato tenha sido carregado com sucesso
            } else if let fact = catFact {
                // Exibe o fato do gato
                HStack(alignment: .top, spacing: 4) {
                    Image(systemName: "cat.fill")
                    Text(fact) // Mostra o fato retornado pela API
                }
            }
        }
        // Define o layout da VStack
        .frame(maxWidth: 300, minHeight: 20, alignment: .leading)
        .padding()
        .background(isLoading || catFact == nil ? Color.clear : Color.green.opacity(0.1)) // Cor de fundo muda quando não está carregando
        .cornerRadius(8) // Deixa os cantos arredondados
        .shimmering(active: isLoading) // Aplica o efeito de shimmer se `isLoading` estiver verdadeiro
   }
}

#Preview {
    CatViewWithoutCompletions() // Preview para ver o layout da view durante o desenvolvimento
}
