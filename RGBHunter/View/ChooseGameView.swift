import SwiftUI

struct ChooseGameView: View {
  var body: some View {
    NavigationStack {
      ZStack {
        Image(.backgroundFirstHalf)
          .resizable()
          .edgesIgnoringSafeArea(.all)
          .opacity(0.7)
        VStack {
          Image(.title)
            .padding()
          VStack(spacing: 50.0) {
            NavigationLink {
              ChooseDifficultyView()
            } label: {
              menuButton(buttonText: "Guess the color")
            }
            .buttonStyle(NoAnimationButtonStyle())
            NavigationLink {
              OtherDifficultyView()
            } label: {
              menuButton(buttonText: "Other game (Soon!)")
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
