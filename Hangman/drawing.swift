import SwiftUI
import UIKit

struct AnimatedHangmanRepresentable: UIViewRepresentable {

    @Binding var wrongGuesses: Int

    func makeUIView(context: Context) -> AnimatedHangmanView {
        return AnimatedHangmanView()
    }

    func updateUIView(_ uiView: AnimatedHangmanView, context: Context) {
        uiView.wrongGuesses = wrongGuesses
        uiView.setNeedsDisplay()  // Redraw the view with the new wrongGuesses value
    }
}

class AnimatedHangmanView: UIView {
    var wrongGuesses = 0
    let offset: CGFloat = 50 // Adjust this value to move the animation

    override func draw(_ rect: CGRect) {
        switch wrongGuesses {
        case 9:
            animateRightLeg()
        case 8:
            animateLeftLeg()
        case 7:
            animateRightArm()
        case 6:
            animateLeftArm()
        case 5:
            animateBody()
        case 4:
            animateHead()
        case 3:
            animateNoose()
        case 2:
            animateHorizontalLine()
        case 1:
            animateVerticalLine()
        default:
            break
        }
    }

    private func animateLine(from start: CGPoint, to end: CGPoint, duration: CFTimeInterval) {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.fillColor = nil
        self.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = duration
        shapeLayer.add(animation, forKey: "drawLineAnimation")
    }

    private func animateCircle(center: CGPoint, radius: CGFloat, duration: CFTimeInterval) {
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.fillColor = nil
        self.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = duration
        shapeLayer.add(animation, forKey: "drawCircleAnimation")
    }

    func animateVerticalLine() {
        let start = CGPoint(x: bounds.midX - 25 - offset, y: bounds.maxY + 50 - offset)
        let end = CGPoint(x: bounds.midX - 25 - offset, y: bounds.midY - 50 - offset)
        animateLine(from: start, to: end, duration: 0.5)
    }

    func animateHorizontalLine() {
        let start = CGPoint(x: bounds.midX - 25 - offset, y: bounds.midY - 50 - offset)
        let end = CGPoint(x: bounds.midX + 100 - offset, y: bounds.midY - 50 - offset)
        animateLine(from: start, to: end, duration: 1.0)
    }

    func animateNoose() {
        let start = CGPoint(x: bounds.midX + 50 - offset, y: bounds.midY - 50 - offset)
        let end = CGPoint(x: bounds.midX + 50 - offset, y: bounds.midY - offset)
        animateLine(from: start, to: end, duration: 1.0)
    }

    func animateHead() {
        let center = CGPoint(x: bounds.midX + 50 - offset, y: bounds.midY + 15 - offset)
        animateCircle(center: center, radius: 15.0, duration: 1.0)
    }

    func animateBody() {
        let start = CGPoint(x: bounds.midX + 50 - offset, y: bounds.midY + 30 - offset)
        let end = CGPoint(x: bounds.midX + 50 - offset, y: bounds.midY + 80 - offset)
        animateLine(from: start, to: end, duration: 1.0)
    }

    func animateLeftArm() {
        let start = CGPoint(x: bounds.midX + 50 - offset, y: bounds.midY + 40 - offset)
        let end = CGPoint(x: bounds.midX + 30 - offset, y: bounds.midY + 60 - offset)
        animateLine(from: start, to: end, duration: 1.0)
    }

    func animateRightArm() {
        let start = CGPoint(x: bounds.midX + 50 - offset, y: bounds.midY + 40 - offset)
        let end = CGPoint(x: bounds.midX + 70 - offset, y: bounds.midY + 60 - offset)
        animateLine(from: start, to: end, duration: 1.0)
    }

    func animateLeftLeg() {
        let start = CGPoint(x: bounds.midX + 50 - offset, y: bounds.midY + 80 - offset)
        let end = CGPoint(x: bounds.midX + 30 - offset, y: bounds.midY + 100 - offset)
        animateLine(from: start, to: end, duration: 1.0)
    }

    func animateRightLeg() {
        let start = CGPoint(x: bounds.midX + 50 - offset, y: bounds.midY + 80 - offset)
        let end = CGPoint(x: bounds.midX + 70 - offset, y: bounds.midY + 100 - offset)
        animateLine(from: start, to: end, duration: 1.0)
    }

    func wrongGuess() {
        wrongGuesses += 1
        setNeedsDisplay()
    }
}

struct ContentView: View {

    @State private var wrongGuesses = 0

    var body: some View {
        VStack {
            AnimatedHangmanRepresentable(wrongGuesses: $wrongGuesses)
                .frame(width: 200, height: 200) // Adjust the frame as needed

            Spacer()

            Button("Make a Wrong Guess") {
                wrongGuesses += 1
            }
            .padding()
        }
    }
}


#Preview {
    ContentView()
}


