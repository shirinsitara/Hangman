import SwiftUI

struct HomeScreen: View {

    @ObservedObject var navigationCoordinator = NavigationCoordinator()
    @StateObject private var viewModel = HangmanViewModel(navigationCoordinator: NavigationCoordinator())

    @State var sliderValue: Double = 4
    let lightOrange: Color = Color(hex: "#FFE1A6")

    var body: some View {

        NavigationView {
            ZStack {

                // NavigationLinks
                NavigationLink(destination: HangmanView(gameModel: HangmanViewModel(navigationCoordinator: navigationCoordinator, wordLength: Int(sliderValue))),
                    tag: "gameScreen",
                    selection: $navigationCoordinator.selection) {
                    EmptyView()
                }

                NavigationLink(destination: ResultsPage(hasWon: true),
                               tag: "winScreen",
                               selection:$navigationCoordinator.selection) {
                    EmptyView()
                }

                NavigationLink(destination: ResultsPage(hasWon: false),
                               tag: "lossScreen",
                               selection:$navigationCoordinator.selection) {
                    EmptyView()
                }
                
                //can you set a navigation link destination within the class
                NavigationLink("test", destination: HomeScreen(),
                               tag: "homeScreen",
                               selection: $navigationCoordinator.selection)

                // Background color
                Color(hex: "#F7B431").ignoresSafeArea()
                
                VStack {
                    Image("hangmanIcon")
                    Text("Welcome to Hangman!")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                        .frame(alignment: .center)

                    Spacer()
                        .frame(height: 40)
                    
                    Text("Choose number of letters:")
                        .foregroundColor(.white)
                        .font(.title2)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text(
                        String(format: "%.0f", sliderValue)
                    )
                    .foregroundColor(.white)
                    .font(.custom("hi", size: 50))
                    .fontWeight(.bold)
                    .padding(.bottom)
                    
                    Slider(value: $sliderValue, in: 4...10, step: 1.0)
                        .accentColor(lightOrange)
                        .cornerRadius(5)
                        .padding(.horizontal, 20)
                        .frame(width: 350)
                        .onChange(of: sliderValue) { newValue in
                            viewModel.sliderValue = newValue
                        }

                    Spacer()
                        .frame(height: 40)
                    
                    Button(action: {
                        navigationCoordinator.navigateToGame()
                    }) {
                        Text("PLAY!")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .padding()
                            .background(
                                Rectangle()
                                    .frame(width: 100, height: 50)
                                    .cornerRadius(12)
                                    .foregroundColor(lightOrange)
                            )
                            .font(.title2)
                    }
                }
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
            }
        }
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    HomeScreen()
}
