import SwiftUI

struct ProgressBar: View {
    var value: Float
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geo.size.width)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                Rectangle()
                    .foregroundColor(Color.blue)
                    .frame(width: CGFloat(self.value) * geo.size.width)
            }
            .cornerRadius(45)
        }
        .frame(height: 10)
        .padding()
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 0.1)
    }
}
