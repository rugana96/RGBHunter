import SwiftUI

struct ChooseGameView: View {
  private let viewModel: ChooseGameView.ViewModel = ChooseGameView.ViewModel()
  var body: some View {
    NavigationStack {
      ZStack {
        Image(.backgroundFirstHalf)
          .resizable()
          .edgesIgnoringSafeArea(.all)
          .opacity(UILayouts.ChooseGameView.backgroundOppacity)
        VStack(spacing: UILayouts.ChooseGameView.viewVStackSpacing) {
          Image(.title)
            .padding()
          VStack(spacing: UILayouts.ChooseGameView.buttonVStackSpacing) {
            NavigationLink {
              ChooseDifficultyView()
            } label: {
              MenuButton(buttonText: viewModel.guessTheColorGameText)
            }
            .buttonStyle(NoAnimationButtonStyle())
            NavigationLink {
              OtherDifficultyView()
            } label: {
              MenuButton(buttonText: viewModel.otherGameText)
            }
            .disabled(true)
            .buttonStyle(NoAnimationButtonStyle())
            Spacer()
          }
        }
      }
    }
  }
}

extension UILayouts {
  enum ChooseGameView {
    public static let backgroundOppacity = 0.7
    public static let buttonVStackSpacing = 50.0
    public static let viewVStackSpacing = 30.0
  }
}

extension ChooseGameView {
  final class ViewModel {
    let guessTheColorGameText: String = String(localized: "guessTheColorGameText")
    let otherGameText: String = String(localized: "otherGameText")
  }
}
