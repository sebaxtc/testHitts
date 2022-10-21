
import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon = Pokemon()
    
    func fetchPokemonDetail(pokemonId id: Int) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let decoded = try? decoder.decode(Pokemon.self, from: data) {
                    DispatchQueue.main.async {
                        self.pokemon = decoded
                    }
                }
            }
        }.resume()
    }
    
    func getMaximumStat() {
        
    }
}
