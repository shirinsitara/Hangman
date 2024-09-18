import SwiftUI

//@main
//struct HangmanApp: App {
//    var body: some Scene {
//        WindowGroup {
//            HangmanView(gameModel: HangmanViewModel())
//        }
//    }
//}

@main
struct HangmanApp: App {
    @StateObject var navigationCoordinator = NavigationCoordinator()

    var body: some Scene {
        WindowGroup {
            let hangmanViewModel = HangmanViewModel(navigationCoordinator: navigationCoordinator)

            HomeScreen(navigationCoordinator: navigationCoordinator)
        }
    }
}
