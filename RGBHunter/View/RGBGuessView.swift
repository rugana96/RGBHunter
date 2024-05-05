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
          .padding(.top, UILayouts.RGBGuessView.navigationItemsTopPadding)
          Spacer()
          InfoButton()
            .padding(.top, UILayouts.RGBGuessView.navigationItemsTopPadding)
        }
        Spacer()
        VStack {
          VStack {
            Text(String(viewModel.partialPoints))
              .font(Fonts.score)
              .bold()
            HStack {
              Text(String(viewModel.avgPoints))
                .font(.title)
                .bold()
              Text(viewModel.avgPointsText)
            }
            .opacity(viewModel.shouldShowAverageText)
          }
          Spacer()
          HStack(spacing: UILayouts.RGBGuessView.circleHStackSpacing) {
            Circle()
              .stroke(.black, lineWidth: UILayouts.RGBGuessView.circleStrokeLineWidth)
              .fill(viewModel.chosenColor)
              .frame(minWidth: UILayouts.RGBGuessView.circleMinFrameWidth, minHeight: UILayouts.RGBGuessView.circleMinFrameWidth)
            if viewModel.isDifficultyNormal {
              Circle()
                .stroke(Color.black, lineWidth: UILayouts.RGBGuessView.circleStrokeLineWidth)
                .fill(viewModel.randomColor)
                .frame(minWidth: UILayouts.RGBGuessView.circleMinFrameWidth, minHeight: UILayouts.RGBGuessView.circleMinFrameWidth)
            } else {
              if viewModel.isCircleVisible {
                ZStack {
                  Circle()
                    .stroke(Color.black, lineWidth: UILayouts.RGBGuessView.circleStrokeLineWidth)
                    .fill(viewModel.randomColor)
                    .frame(minWidth: UILayouts.RGBGuessView.circleMinFrameWidth, minHeight: UILayouts.RGBGuessView.circleMinFrameWidth)
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
                .fixedSize()
              Slider(value: $viewModel.redSlider, in: UILayouts.RGBGuessView.sliderRange)
                .tint(Color.red)
                .padding(.trailing, viewModel.sliderPadding)
                .fixedSize(horizontal: false, vertical: true)
              if viewModel.isDifficultyNormal {
                Text(String(viewModel.redSlider.tosRGB()))
                  .frame(width: UILayouts.RGBGuessView.sliderTextFrameWidth)
                  .bold()
                  .fixedSize()
              }
            }
            .padding()
            
            HStack {
              Text(viewModel.G)
                .padding(UILayouts.RGBGuessView.sliderTextPadding)
                .bold()
                .fixedSize()
              Slider(value: $viewModel.greenSlider, in: UILayouts.RGBGuessView.sliderRange)
                .tint(Color.green)
                .padding(.trailing, viewModel.sliderPadding)
                .fixedSize(horizontal: false, vertical: true)
              if viewModel.isDifficultyNormal {
                Text(String(viewModel.greenSlider.tosRGB()))
                  .frame(width: UILayouts.RGBGuessView.sliderTextFrameWidth)
                  .bold()
                  .fixedSize()
              }
            }
            .padding()
            
            HStack {
              Text(viewModel.B)
                .bold()
                .padding(UILayouts.RGBGuessView.sliderTextPadding)
                .fixedSize()
              Slider(value: $viewModel.blueSlider, in: UILayouts.RGBGuessView.sliderRange)
                .tint(Color.blue)
                .padding(.trailing, viewModel.sliderPadding)
                .fixedSize(horizontal: false, vertical: true)
              if viewModel.isDifficultyNormal {
                Text(String(viewModel.blueSlider.tosRGB()))
                  .frame(width: UILayouts.RGBGuessView.sliderTextFrameWidth)
                  .bold()
                  .fixedSize()
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
              .frame(
                minWidth: UILayouts.RGBGuessView.checkMinFrameWidth,
                maxWidth: UILayouts.RGBGuessView.checkMaxFrameWidth,
                minHeight: UILayouts.RGBGuessView.checkMinFrameWidth,
                maxHeight: UILayouts.RGBGuessView.checkMaxFrameWidth
              )
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
  RGBGuessView(difficulty: .normal)
}

#Preview {
  RGBGuessView(difficulty: .difficult)
}

extension UILayouts {
  enum RGBGuessView {
    public static let sliderRange = 0.0...255.0
    public static let sliderVStackSpacing = 20.0
    public static let sliderTextFrameWidth = 40.0
    public static let sliderTextPadding = 5.0
    public static let sliderPadding = 20.0
    public static let strokeLineWidth = 2.0
    public static let checkMinFrameWidth = 50.0
    public static let checkMaxFrameWidth = 70.0
    public static let checkBottomPadding = 50.0
    public static let backgroundOpacity = 0.3
    public static let backButtonLeadingPadding = 20.0
    public static let circleHStackSpacing = 70.0
    public static let circleStrokeLineWidth = 5.0
    public static let circleMinFrameWidth = 100.0
    public static let navigationItemsTopPadding = 20.0
    public static let minimunScaleFactor = 20.0
  }
}

enum Fonts {
  public static let score: Font = .custom("Score", size: 80)
}
