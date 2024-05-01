import SwiftUI

struct ChooseDifficultyView: View {
  @Environment(\.dismiss) var dismiss
  var body: some View {
    NavigationStack {
      ZStack {
        Image(.backgroundSecondHalf)
          .resizable()
          .edgesIgnoringSafeArea(.all)
          .opacity(0.7)
        VStack {
          HStack {
            Button {
              dismiss()
            } label: {
              BackButton()
            }
            .buttonStyle(NoAnimationButtonStyle())
            .padding(.leading, 20)
            Spacer()
          }
          Image(.title)
            .padding(.bottom)
          VStack(spacing: 50.0) {
            NavigationLink {
              RGBGuessView(difficulty: .normal)
            } label: {
              menuButton(buttonText: "Normal")
            }
            .buttonStyle(NoAnimationButtonStyle())
            NavigationLink {
              RGBGuessView(difficulty: .difficult)
            } label: {
              menuButton(buttonText: "Difficult")
            }
            .buttonStyle(NoAnimationButtonStyle())
            Spacer()
          }
        }
      }
      .transition(.slide)
    }
    .navigationBarBackButtonHidden()
  }
}