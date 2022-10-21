import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    @State var typeName = ""
    
    var body: some View {
        NavigationView {
            List(viewModel.pokemonList.indices, id: \.self) { index in
                NavigationLink(destination: PokemonDetailView(id: index + 1, typeName: $typeName)) {
                    HStack {
                        ImageView(withURL: viewModel.getImageURL(pokemonId: index + 1))
                        Text(viewModel.pokemonList[index].formattedName)
                    }
                }
            }
            .navigationTitle("Pokedex")
        }
        .onAppear(perform: viewModel.fetchData)
    }
}
