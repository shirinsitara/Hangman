import SwiftUI

class NavigationCoordinator: ObservableObject {
    @Published var selection: String? = nil

    func navigateToGame() {
        selection = "gameScreen"
    }

    func navigateToWin() {
        print("moving to win screen")
        selection = "winScreen"
    }

    func navigateToLoss() {
        print("moving to loss")
        selection = "lossScreen"
    }

    func navigateToHome() {
        print("moving to home")
        selection = "homeScreen"
    }
}


