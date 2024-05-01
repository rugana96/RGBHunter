import SwiftUI

extension RGBGuessView {
  final class ViewModel: ObservableObject {
    @Published var redSlider: Double = .zero
    @Published var greenSlider: Double = .zero
    @Published var blueSlider: Double = .zero
    
    @Published var randomColorRed: Double = Double.random(in: 0...1)
    @Published var randomColorGreen: Double = Double.random(in: 0...1)
    @Published var randomColorBlue: Double = Double.random(in: 0...1)
    
    @Published var isCircleVisible = true
    
    var chosenColorRed: Double {
      redSlider.tosRGB()
    }
    var chosenColorGreen: Double {
      greenSlider.tosRGB()
    }
    var chosenColorBlue: Double {
      blueSlider.tosRGB()
    }
    
    var chosenColor: Color {
      Color(
        red: chosenColorRed,
        green: chosenColorGreen,
        blue: chosenColorBlue
      )
    }
    
    var randomColor: Color = .blue
    var victoryText: String = ""
    
    var pointsScored: Int = 0
    var totalPoints: Int = 0
    
    init() {
      self.generateRandomColor()
    }
    
    func update(isCircleVisible: Bool) {
      self.isCircleVisible = isCircleVisible
    }
    
    func generateRandomColor() {
      randomColorRed = Double.random(in: 0...1).round(to: 2)
      randomColorGreen = Double.random(in: 0...1).round(to: 2)
      randomColorBlue = Double.random(in: 0...1).round(to: 2)
      self.randomColor = Color(red: randomColorRed, green: randomColorGreen, blue: randomColorBlue)
    }
    
    func calculateScore() {
      let maxDistanceFromMidpoint = 0.5
      let deltaRed = abs(chosenColorRed - randomColorRed)
      let deltaGreen = abs(chosenColorGreen - randomColorGreen)
      let deltaBlue = abs(chosenColorBlue - randomColorBlue)

      let redScore = calculateIndividualScore(delta: deltaRed, maxDistance: maxDistanceFromMidpoint)
      let blueScore = calculateIndividualScore(delta: deltaBlue, maxDistance: maxDistanceFromMidpoint)
      let greenScore = calculateIndividualScore(delta: deltaGreen, maxDistance: maxDistanceFromMidpoint)

      pointsScored = Int(redScore + blueScore + greenScore)
      totalPoints += pointsScored

      switch pointsScored {
      case 0..<100:
        victoryText = "Sorry, try again next time."
      case 100..<200:
        victoryText = "Close, but not quite there."
      case 200..<299:
        victoryText = "Great job! You're really close!"
      case 300:
        victoryText = "That was perfect! You have a really good eye!"
      default:
        victoryText = "Close, but not quite there."
      }
    }

    private func calculateIndividualScore(delta: Double, maxDistance: Double) -> Double {
      let rawScore = 100.0 * (1.0 - delta / maxDistance)
      return max(0, min(100, rawScore))
    }
    
    func resetChosenColor() {
      redSlider = .zero
      greenSlider = .zero
      blueSlider = .zero
    }
    
    func resetGame() {
      generateRandomColor()
      victoryText = ""
      pointsScored = 0
      resetChosenColor()
      update(isCircleVisible: true)
    }
  }
}
