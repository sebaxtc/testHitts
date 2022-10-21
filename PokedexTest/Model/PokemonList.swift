
import Foundation

struct Result: Decodable {
    var results: [PokemonList]
}

struct PokemonList: Decodable {
    var name: String
    var url: String
    
    var formattedName: String {
        String(Array(name)[0].uppercased() + name.dropFirst())
    }
}
