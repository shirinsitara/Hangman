import SwiftUI


struct SquareTileButtonStyle: ButtonStyle {

    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(!isEnabled ? .brown : .white)
            .frame(width: 40, height: 40)
            .background(configuration.isPressed ? Color.white: Color(hex: "#F7B431"))
            .cornerRadius(8)
            .opacity(isEnabled ? 1 : 0.5)
    }

}

struct SquareTile: View {
    
    var text: Character
    var action: (Character) -> Void

    var body: some View {
        Button(String(text)) {
            action(text)
        }
        .buttonStyle(SquareTileButtonStyle())
        .foregroundColor(Color(hex: "#F7B431"))
    }
}
