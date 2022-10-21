import SwiftUI

struct Attribute: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(5)
            .background(color)
            .clipShape(Capsule())
    }
}
