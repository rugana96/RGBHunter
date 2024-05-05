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
    
    @Published var showingAlert = false
    
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
    
    var difficulty: Difficulty
    
    var randomColor: Color = .blue
    var victoryText: String = ""
    
    @Published var countdown = 5
    
    var pointsScored: Int = 0
    var totalPoints: Int = 0
    var partialPoints: Int = 0
    var avgPoints: Int = 0
    var totalPlays: Int = 0
    
    let R: String = "R"
    let G: String = "G"
    let B: String = "B"
    let okButtonText: String = "OK"
    let checkmarkImageSystemName: String = "checkmark"
    let secondsToDissapear: Double = 5
    
    var avgPointsText: String {
      if totalPlays == 1 {
        "in \(totalPlays) game"
      } else {
        "in \(totalPlays) games"
      }
    }
    
    var sliderPadding: CGFloat {
      isDifficultyNormal ? .zero : UILayouts.RGBGuessView.sliderPadding
    }
    
    init(
      difficulty: Difficulty
    ) {
      self.difficulty = difficulty
      self.generateRandomColor()
    }
    
    var isDifficultyNormal: Bool {
      difficulty == .normal
    }
    
    func update(isCircleVisible: Bool) {
      self.isCircleVisible = isCircleVisible
    }
    
    private func generateRandomColor() {
      randomColorRed = Double.random(in: 0...1).round(to: 2)
      randomColorGreen = Double.random(in: 0...1).round(to: 2)
      randomColorBlue = Double.random(in: 0...1).round(to: 2)
      self.randomColor = Color(red: randomColorRed, green: randomColorGreen, blue: randomColorBlue)
    }
    
    func calculateScore() {
      let maxScorePerColor = 100.0
      
      let deltaRed = abs(chosenColorRed - randomColorRed)
      let deltaGreen = abs(chosenColorGreen - randomColorGreen)
      let deltaBlue = abs(chosenColorBlue - randomColorBlue)
      
      let redScore = max(0, maxScorePerColor - (deltaRed * maxScorePerColor))
      let greenScore = max(0, maxScorePerColor - (deltaGreen * maxScorePerColor))
      let blueScore = max(0, maxScorePerColor - (deltaBlue * maxScorePerColor))
      
      pointsScored = Int(redScore + greenScore + blueScore)
      totalPoints += pointsScored
      partialPoints = pointsScored
      totalPlays += 1
      avgPoints = totalPoints / totalPlays
      
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
    
    private func resetChosenColor() {
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
      countdown = 5
    }
  }
}
