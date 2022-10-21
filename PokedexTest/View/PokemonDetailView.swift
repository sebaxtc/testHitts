
import SwiftUI

struct PokemonDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel = PokemonDetailViewModel()
    var typeName: Binding<String>
    private var id: Int
    
    init(id: Int, typeName: Binding<String>) {
        self.id = id
        self.typeName = typeName
        viewModel.fetchPokemonDetail(pokemonId: id)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("#\(self.id, specifier: "%0.3d")")
                    .font(.title)
                HStack(spacing: 30) {
                    ForEach(0..<viewModel.pokemon.types.count) { index in
                        Text(viewModel.pokemon.types[index].type.name)
                            .attributeStyle(color: Color.random)
                            .onTapGesture {
                                typeName.wrappedValue = viewModel.pokemon.types[index].type.name
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
                HStack {
                    VStack {
                        ImageView(withURL: viewModel.pokemon.sprites.frontDefault)
                        Text("Front")
                    }
                    VStack {
                        ImageView(withURL: viewModel.pokemon.sprites.frontShiny)
                        Text("Front Shiny")
                    }
                }
                HStack(spacing: 30) {
                    VStack {
                        Text("Height")
                            .attributeStyle(color: Color.orange)
                        Text("\(viewModel.pokemon.height) cm")
                    }
                    VStack {
                        Text("Weight")
                            .attributeStyle(color: Color.blue)
                        Text("\(viewModel.pokemon.weight) kg")
                    }
                }
                Section(header: Text("Stats").font(.headline)) {
                    ForEach(viewModel.pokemon.stats, id: \.stat.name) { stat in
                        VStack {
                            HStack(spacing: 25) {
                                Group {
                                    Text(stat.formattedName)
                                        .fontWeight(.bold)
                                        .frame(minWidth: 60, alignment: .leading)
                                    Text("\(stat.baseStat)")
                                        .frame(minWidth: 40)
                                }
                                ProgressBar(value: Float(stat.baseStat) / Float(stat.maximumStat))
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding(25)
        }
        .navigationBarTitle(Text(viewModel.pokemon.formattedName), displayMode: .inline)
    }
}
