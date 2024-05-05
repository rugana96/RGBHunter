import SwiftUI

struct ChooseDifficultyView: View {
  @Environment(\.dismiss) private var dismiss
  private let viewModel: ChooseDifficultyView.ViewModel = ChooseDifficultyView.ViewModel()
  var body: some View {
    NavigationStack {
      ZStack {
        Image(.backgroundSecondHalf)
          .resizable()
          .edgesIgnoringSafeArea(.all)
          .opacity(UILayouts.ChooseDifficultyView.backgroundOpacity)
        VStack {
          HStack {
            Button {
              dismiss()
            } label: {
              BackButton()
            }
            .buttonStyle(NoAnimationButtonStyle())
            .padding(.top, UILayouts.ChooseDifficultyView.backButtonPadding)
            .padding(.leading, UILayouts.ChooseDifficultyView.backButtonPadding)
            Spacer()
          }
          Image(.title)
            .resizable()
            .frame(
              width: UILayouts.ChooseDifficultyView.titleImageWidth,
              height: UILayouts.ChooseDifficultyView.titleImageHeight
            )
            .padding(.bottom)
          VStack(spacing: UILayouts.ChooseDifficultyView.buttonVStackSpacing) {
            NavigationLink {
              RGBGuessView(difficulty: .normal)
            } label: {
              MenuButton(buttonText: viewModel.normalDifficultyText)
            }
            .buttonStyle(NoAnimationButtonStyle())
            NavigationLink {
              RGBGuessView(difficulty: .difficult)
            } label: {
              MenuButton(buttonText: viewModel.difficultDifficultyText)
            }
            .buttonStyle(NoAnimationButtonStyle())
            Spacer()
          }
        }
      }
    }
    .navigationBarBackButtonHidden()
  }
}

extension UILayouts {
  enum ChooseDifficultyView {
    public static let titleImageWidth = 300.0
    public static let titleImageHeight = 330.0
    public static let buttonVStackSpacing = 50.0
    public static let backButtonPadding = 20.0
    public static let backgroundOpacity = 0.7
  }
}

extension ChooseDifficultyView {
  final class ViewModel {
    let normalDifficultyText: String = String(localized: "normal")
    let difficultDifficultyText: String = String(localized: "difficult")
  }
}


