import SwiftUI

extension View {
    func attributeStyle(color: Color) -> some View {
        self.modifier(Attribute(color: color))
    }
}
