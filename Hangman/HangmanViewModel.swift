import Combine

class HangmanViewModel: ObservableObject {

    @Published var game: Game
    @Published var revealedWord: String = ""
    @Published var keys: [String] = []
    @Published var wrongGuesses: Int = 0  // Initialize as zero
    @Published var sliderValue: Double = 0.0

    private var navigationCoordinator: NavigationCoordinator
    private let wordStore = WordStore()

    var gameState: GameState {
        game.gameState
    }

    var lives: Int {
        game.player.lives
    }

    init(navigationCoordinator: NavigationCoordinator) {
        self.navigationCoordinator = navigationCoordinator
        self.game = Game(5)
        print("new game created")
        self.revealedWord = game.revealedWord
        self.keys = Keys().generateKeys()
        //let words = wordStore.getWordOfLength(Int(sliderValue))
        startGame()
    }

    init(navigationCoordinator: NavigationCoordinator, wordLength: Int) {
        self.navigationCoordinator = navigationCoordinator
        self.game = Game(wordLength)
        print("new game created")
        self.revealedWord = game.revealedWord
        self.keys = Keys().generateKeys()
        //let words = wordStore.getWordOfLength(Int(sliderValue))
        startGame()
    }

    func startGame() {
        game.startGame()
        keys = Keys().generateKeys()
        updateWrongGuesses() 
        updateWordLength()
    }

//    func restartGame() {
//        game.player.lives = 5
//        game.restartGame()  // Assuming there is a restart method in Game
//        startGame()
//    }

    func guessLetter(_ char: Character) {
        game.guess(char)
        updateRevealedWord()
        updateWrongGuesses()  // Update wrongGuesses based on game state
        checkGameState()
        print("The word is:", revealedWord)
        print(wrongGuesses)
    }

    func updateRevealedWord() {
        self.revealedWord = game.revealedWord
    }

    func canBeSelected(_ character: Character) -> Bool {
        game.canBeSelected(character)
    }

    func updateWordLength() {
        game.wordLength = Int(self.sliderValue)
    }

    private func updateWrongGuesses() {
        self.wrongGuesses = game.wrongGuesses  // Sync with the game's wrongGuesses
    }

    private func checkGameState() {
        switch game.gameState {
        case .completeWin:
            navigationCoordinator.navigateToWin()
        case .completeLoss:
            navigationCoordinator.navigateToLoss()
        default:
            print("in game mode")
            break
        }
    }
}

