import SwiftUI

struct ContentView: View {
    @Environment(\.isSearching) var isSearching
    @ObservedObject var viewModel = PokemonViewModel()
    @State var typeName = ""
    @State private var searchText = ""
    @State var loaded: Bool = true
    @State var searchResults: [PokemonList] = []
    @State var suggestedSearches: [String] = []
    @State var searchByType: Bool = false

    
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
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                if searchText.isEmpty {
                    searchResults = []
                }
                else {
                    DispatchQueue.main.async {
                        loaded = false
                    }
                    if searchByType {
                        self.viewModel.searchByType(type: searchText)
                    }
                    else {
                        self.viewModel.searchByName(name: searchText)
                    }
                }
            }
            .onChange(of: isSearching) { newValue in
                if !newValue {
                    viewModel.pokemonList.removeAll()
                    searchResults = []
                }
            }
        }
        .onAppear(perform: viewModel.fetchData)
    }
}
