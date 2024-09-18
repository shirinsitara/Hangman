import SwiftUI

struct ResultsPage: View {

    private var navigationCoordinator = NavigationCoordinator()

    private var hasWon: Bool = false

    @State var sliderValue: Double = 4
    @State var lightOrange: Color = Color(hex: "#FFE1A6")

    init(hasWon: Bool) {
        self.hasWon = hasWon
    }


    var body: some View {
        if (hasWon) {
            makePage(resultText: "you win", resultImage: "partyCone", buttonImage:"homeIcon", buttonText: "Main Menu")
        } else {
            makePage(resultText: "game over", resultImage: "crossIcon", buttonImage: "retryArrow", buttonText: "Try again")
        }

    }

    func makePage(resultText: String, resultImage: String, buttonImage: String, buttonText:String) -> some View {
        var resultView: some View {
            ZStack{
                Color(hex: "#F7B431").ignoresSafeArea()
                VStack{
                    Text(resultText)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.largeTitle)

                    Spacer()
                        .frame(height: 40)

                    Image(resultImage)

                    Spacer()
                        .frame(height: 40)

                    Button(action: {
                        //add navigation logic
                        navigationCoordinator.navigateToHome()
                    }) {
                        HStack (alignment: .center, spacing: 10){
                            Image(buttonImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                            Text(buttonText)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                        }
                        .padding()
                    }
                    .background(
                        Rectangle()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200,
                                   height: 65)
                            .cornerRadius(12)
                    )
                    .padding()
                    .font(.title2)
                    .foregroundColor(lightOrange)
                }
            }
        }
        return resultView
    }

}



#Preview {
    ResultsPage(hasWon: false)
}

