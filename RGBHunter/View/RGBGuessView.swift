import SwiftUI

struct RGBGuessView: View {
  @StateObject private var viewModel: RGBGuessView.ViewModel
  @Environment(\.dismiss) private var dismiss
  
  public init (
    difficulty: Difficulty
  ) {
    _viewModel = StateObject(wrappedValue: RGBGuessView.ViewModel(difficulty: difficulty))
  }
  
  var body: some View {
    ZStack {
      Image(.background)
        .resizable()
        .edgesIgnoringSafeArea(.all)
        .opacity(UILayouts.RGBGuessView.backgroundOpacity)
      VStack {
        HStack {
          Button {
            dismiss()
          } label: {
            BackButton()
          }
          .buttonStyle(NoAnimationButtonStyle())
          .padding(.leading, UILayouts.RGBGuessView.backButtonLeadingPadding)
          Spacer()
          InfoButton()
        }
        Spacer()
        VStack {
          VStack {
            Text(String(viewModel.partialPoints))
              .font(Fonts.score)
              .bold()
            if viewModel.totalPlays > .zero {
              HStack {
                Text(String(viewModel.avgPoints))
                  .font(.title)
                  .bold()
                Text(viewModel.avgPointsText)
              }
            }
          }
          Spacer()
          HStack(spacing: UILayouts.RGBGuessView.circleHStackSpacing) {
            Circle()
              .stroke(.black, lineWidth: UILayouts.RGBGuessView.circleStrokeLineWidth)
              .fill(viewModel.chosenColor)
              .frame(width: UILayouts.RGBGuessView.circleFrameWidth)
            if viewModel.isDifficultyNormal {
              Circle()
                .stroke(Color.black, lineWidth: UILayouts.RGBGuessView.circleStrokeLineWidth)
                .fill(viewModel.randomColor)
                .frame(width: UILayouts.RGBGuessView.circleFrameWidth)
            } else {
              if viewModel.isCircleVisible {
                ZStack {
                  Circle()
                    .stroke(Color.black, lineWidth: UILayouts.RGBGuessView.circleStrokeLineWidth)
                    .fill(viewModel.randomColor)
                    .frame(width: UILayouts.RGBGuessView.circleFrameWidth)
                  Text("\(viewModel.countdown)")
                    .font(.title)
                    .foregroundColor(.white)
                }
                .onAppear {
                  Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    if viewModel.countdown > 0 {
                      viewModel.countdown -= 1
                    } else {
                      timer.invalidate()
                      withAnimation {
                        viewModel.update(isCircleVisible: false)
                      }
                    }
                  }
                }
              }
            }
          }
          .padding()
          Spacer()
          VStack(spacing: UILayouts.RGBGuessView.sliderVStackSpacing) {
            HStack {
              Text(viewModel.R)
                .padding(UILayouts.RGBGuessView.sliderTextPadding)
                .bold()
              Slider(value: $viewModel.redSlider, in: UILayouts.RGBGuessView.sliderRange)
                .tint(Color.red)
                .padding(.trailing, viewModel.sliderPadding)
              if viewModel.isDifficultyNormal {
                Text(String(viewModel.redSlider.tosRGB()))
                  .frame(width: UILayouts.RGBGuessView.checkFrameWidth)
                  .bold()
              }
            }
            .padding()
            HStack {
              Text(viewModel.G)
                .bold()
                .padding(UILayouts.RGBGuessView.sliderTextPadding)
              Slider(value: $viewModel.greenSlider, in: UILayouts.RGBGuessView.sliderRange)
                .tint(Color.green)
                .padding(.trailing, viewModel.sliderPadding)
              if viewModel.isDifficultyNormal {
                Text(String(viewModel.redSlider.tosRGB()))
                  .frame(width: UILayouts.RGBGuessView.checkFrameWidth)
                  .bold()
              }
            }
            .padding()
            HStack {
              Text(viewModel.B)
                .bold()
                .padding(UILayouts.RGBGuessView.sliderTextPadding)
              Slider(value: $viewModel.blueSlider, in: UILayouts.RGBGuessView.sliderRange)
                .tint(Color.blue)
                .padding(.trailing, viewModel.sliderPadding)
              if viewModel.isDifficultyNormal {
                Text(String(viewModel.redSlider.tosRGB()))
                  .frame(width: UILayouts.RGBGuessView.checkFrameWidth)
                  .bold()
              }
            }
            .padding()
          }
          Spacer()
          Button(action: {
            viewModel.calculateScore()
            viewModel.showingAlert = true
          }, label: {
            Circle()
              .stroke(.black, lineWidth: UILayouts.RGBGuessView.strokeLineWidth)
              .fill(.green)
              .frame(width: UILayouts.RGBGuessView.checkFrameWidth)
              .overlay {
                Image(systemName: viewModel.checkmarkImageSystemName)
                  .foregroundStyle(.white)
              }
          })
          .padding(.bottom, UILayouts.RGBGuessView.checkBottomPadding)
          .alert(Text(viewModel.victoryText), isPresented: $viewModel.showingAlert) {
            Button(viewModel.okButtonText, role: .cancel) {
              viewModel.resetGame()
            }
          }
        }
      }
    }
    .navigationBarBackButtonHidden()
  }
}

#Preview {
  RGBGuessView(difficulty: .difficult)
}

extension UILayouts {
  enum RGBGuessView {
    public static let sliderRange = 0.0...255.0
    public static let sliderVStackSpacing = 30.0
    public static let sliderTextFrameWidth = 40.0
    public static let sliderTextPadding = 5.0
    public static let sliderPadding = 20.0
    public static let strokeLineWidth = 2.0
    public static let checkFrameWidth = 70.0
    public static let checkBottomPadding = 30.0
    public static let backgroundOpacity = 0.3
    public static let backButtonLeadingPadding = 20.0
    public static let circleHStackSpacing = 70.0
    public static let circleStrokeLineWidth = 5.0
    public static let circleFrameWidth = 130.0
  }
}

enum Fonts {
  public static let score: Font = .custom("Score", size: 80)
}
