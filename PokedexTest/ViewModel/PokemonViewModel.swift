
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
    
    func searchByName(name: String) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())"
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                var pokeData = [String: Any]()
                do {
                    pokeData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                    let pokelist = PokemonList(name: pokeData["name"] as! String, url: "https://pokeapi.co/api/v2/pokemon/\(pokeData["id"] as! Int)")
                    DispatchQueue.main.async {
                        self.pokemonList.removeAll()
                        self.pokemonList.append(pokelist)
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }.resume()
    }
    
    func searchByType(type: String) {
        let request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/type/" + type + "/")!)
        
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
