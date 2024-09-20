class Game {
    
    var wordLength:Int
    private var words: [Word] = [Word(content: "today"), Word(content: "yesterday"), Word(content: "apple"), Word(content: "king")]
    //private var words: [Word] = []
    private let navigationCoordinator: NavigationCoordinator

    var player: Player
    private var wordInPlay: Word
    var guessedLetters: Set<Character> = Set()
    var gameState = GameState.inProgress
    private(set) var wrongGuesses: Int = 0

    var revealedWord: String {
        var reveal = ""
        for letter in wordInPlay.content {
            let result = guessedLetters.contains(letter) ? letter : "_"
            reveal.append(String(result) + " ")
        }
        return reveal
    }

    init(_ wordLength: Int) {
        self.wordLength = wordLength
        self.words = WordStore().getWordOfLength(wordLength)
        self.player = Player()
        self.guessedLetters = Set()
        self.navigationCoordinator = NavigationCoordinator()
        self.wordInPlay = words.shuffled()[0]
    }
    
    func startGame(){
        //self.wordInPlay = words.first!//randomize word selection
        self.gameState = .inProgress
    }
    
    func guess(_ char: Character) {
        guard gameState == .inProgress else { return }
        let input = Character(char.lowercased())
        guessedLetters.insert(input)

        if wordInPlay.content.contains(input) == false {
            player.lives -= 1
            wrongGuesses += 1
        }
        
        //loss logic
        if player.lives <= 0 {
            self.gameState = .completeLoss
        }
        
        //win logic
        if wordInPlay.content == revealedWord.replacingOccurrences(of: " ", with: "") {
            self.gameState = .completeWin
        }
    }
    
    func guessOutput() {
        print(revealedWord)
        print(player.lives)
        print(gameState)
    }

    func canBeSelected(_ character: Character) -> Bool {
        !guessedLetters.contains(character.lowercased())
    }

}

enum GameState: String {
    case idle, inProgress, completeWin, completeLoss
}

