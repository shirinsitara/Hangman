import Foundation

struct WordStore {

    let wordsByLength:[Int: [String]] = [
        4: ["fish", "tree"],
        5: ["apple", "beach"],
        6: ["orange", "guitar"],
        7: ["country", "journey"],
        8: ["backyard", "horizon"],
        9: ["adventure", "mysterious"],
        10: ["sandstorms", "waterfalls"]
    ]

    func getWordOfLength(_ length: Int) -> [Word] {

        if let words = wordsByLength[length] {
            return words.map { Word(content: $0)}
        } else {
            return []
        }
    }

}
