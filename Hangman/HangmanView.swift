import SwiftUI

struct HangmanView: View {

    @ObservedObject var gameModel: HangmanViewModel

    var body: some View {
        NavigationView {
            VStack {
                livesBox
                imagePanel
                guessBox
                keyboard
            }
            .padding(.top, 50)
        }
    }

    @ViewBuilder
    var livesBox: some View {
        Text("Number of lives left: \(gameModel.lives)")
    }

    @ViewBuilder
    var imagePanel: some View {
        ZStack {
            Image("notepadCanvas")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .frame(width: 500, height: 350)
            AnimatedHangmanRepresentable(wrongGuesses: $gameModel.wrongGuesses)
                .frame(width: 300, height: 200)
        }
    }

    @ViewBuilder
    var guessBox: some View{
        Text(gameModel.revealedWord)
            .font(.largeTitle)
    }

    @ViewBuilder
    var keyboard: some View {

        //Look into different ways to define a grid

        LazyVGrid(columns: [GridItem(.adaptive(minimum: 20), spacing:30)]) {
            ForEach(0..<gameModel.keys.count, id: \.self) { index in
                let letter = Character(gameModel.keys[index])
                SquareTile(text: letter,
                           action: gameModel.guessLetter(_:))
                .padding(4)
                .cornerRadius(7)
                .disabled(!gameModel.canBeSelected(letter))
            }
        }
        .padding(30)
    }
}



#Preview {
    HangmanView(gameModel: HangmanViewModel(navigationCoordinator: NavigationCoordinator()))
}
