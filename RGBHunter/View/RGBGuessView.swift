import SwiftUI

struct RGBGuessView: View {
  @StateObject var viewModel: RGBGuessView.ViewModel = RGBGuessView.ViewModel()
  @State private var showingAlert = false
  let difficulty: Difficulty
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      Image(.background)
        .resizable()
        .edgesIgnoringSafeArea(.all)
        .opacity(0.3)
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
          InfoButton()
        }
        Spacer()
        VStack {
          Text(String(viewModel.totalPoints))
            .font(.custom("Score", size: 80))
            .bold()
          Spacer()
          HStack {
            Circle()
              .stroke(.black, lineWidth: 5)
              .fill(viewModel.chosenColor)
              .frame(width: 130)
            Spacer()
            if difficulty == .normal {
              Circle()
                .stroke(Color.black, lineWidth: 5)
                .fill(viewModel.randomColor)
                .frame(width: 130)
            } else {
              if viewModel.isCircleVisible {
                Circle()
                  .stroke(Color.black, lineWidth: 5)
                  .fill(viewModel.randomColor)
                  .frame(width: 130)
                  .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                      withAnimation {
                        viewModel.update(isCircleVisible: false)
                      }
                    }
                  }
              }
            }
          }
          .padding()
          Spacer()
          VStack(spacing: 30) {
            HStack {
              Text("R")
                .padding(5)
                .bold()
              Slider(value: $viewModel.redSlider, in: 0...255)
                .tint(Color.red)
              Text(String(viewModel.redSlider.tosRGB()))
                .frame(width: 40)
                .bold()
                .opacity(difficulty == .normal ? 1 : 0)
            }
            .padding()
            HStack {
              Text("G")
                .bold()
                .padding(5)
              Slider(value: $viewModel.greenSlider, in: 0...255)
                .tint(Color.green)
              Text(String(viewModel.greenSlider.tosRGB()))
                .frame(width: 40)
                .bold()
                .opacity(difficulty == .normal ? 1 : 0)
            }
            .padding()
            HStack {
              Text("B")
                .bold()
                .padding(5)
              Slider(value: $viewModel.blueSlider, in: 0...255)
                .tint(Color.blue)
              Text(String(viewModel.blueSlider.tosRGB()))
                .frame(width: 40)
                .bold()
                .opacity(difficulty == .normal ? 1 : 0)
            }
            .padding()
          }
          Spacer()
          Button(action: {
            viewModel.calculateScore()
            showingAlert = true
          }, label: {
            Circle()
              .stroke(.black, lineWidth: 2)
              .fill(.green)
              .frame(width: 70)
              .overlay {
                Image(systemName: "checkmark")
                  .foregroundStyle(.white)
              }
          })
          .padding(.bottom, 30)
          .alert(Text(viewModel.victoryText), isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
              viewModel.resetGame()
            }
          }
        }
      }
    }
    .navigationBarBackButtonHidden()
  }
}
