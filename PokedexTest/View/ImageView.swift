
import SwiftUI

struct ImageView: View {
    @State var image: UIImage = UIImage()
    var urlString: String = ""

    init(withURL url: String) {
        self.urlString = url
    }

    var body: some View {
        AsyncImage(
            url: URL(string: urlString),
            content: { image in
                image.resizable()
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL:  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
    }
}
