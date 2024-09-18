struct Keys {

    func generateKeys ()->[String] {
        return (0..<26).map { String(UnicodeScalar(65 + $0)) }
    }
}
