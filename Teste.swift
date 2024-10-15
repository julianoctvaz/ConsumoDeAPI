import SwiftUI

struct TesteView: View {
    let products: [Product?] = [
        nil,
        Product(name: nil, points: nil, description: nil),
        Product(name: "Product A", points: nil, description: nil),
        Product(name: nil, points: 10, description: nil),
        Product(name: nil, points: nil, description: "Description A"),
        Product(name: "Product A", points: 10, description: nil),
        Product(name: "Product A", points: nil, description: "Description A"),
        Product(name: nil, points: 10, description: "Description A"),
        Product(name: "Product A", points: 10, description: "Description A")
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<products.count, id: \.self) { index in
                    if let product = products[index] {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Name: \(product.name ?? "No Name")")
                            Text("Points: \(product.points?.description ?? "No Points")")
                            Text("Description: \(product.description ?? "No Description")")
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                    } else {
                        Text("Product is nil")
                            .frame(width: 210)
                            .italic()
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
            }
            .padding()

        }
    }
}

#Preview {
    TesteView()
}
