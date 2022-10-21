
import Foundation

class PokemonViewModel: ObservableObject {
    private let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20")!
    @Published var pokemonList = [PokemonList]()
    
    
    func fetchData() {
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decoded = try? JSONDecoder().decode(Result.self, from: data) {
                    DispatchQueue.main.async {
                        self.pokemonList = decoded.results
                    }
                }
            }
        }.resume()
    }
    
    func getImageURL(pokemonId id: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
