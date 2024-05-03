import SwiftUI

struct RGBGuessView: View {
  @StateObject private var viewModel: RGBGuessView.ViewModel
  @State private var showingAlert = false
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
          Text(String(viewModel.totalPoints))
            .font(.custom("Score", size: 80))
            .bold()
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
                Circle()
                  .stroke(Color.black, lineWidth: UILayouts.RGBGuessView.circleStrokeLineWidth)
                  .fill(viewModel.randomColor)
                  .frame(width: UILayouts.RGBGuessView.circleFrameWidth)
                  .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + viewModel.secondsToDissapear) {
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
          VStack(spacing: UILayouts.RGBGuessView.sliderVStackSpacing) {
            HStack {
              Text(viewModel.R)
                .padding(UILayouts.RGBGuessView.sliderTextPadding)
                .bold()
              Slider(value: $viewModel.redSlider, in: UILayouts.RGBGuessView.sliderRange)
                .tint(Color.red)
                .padding(viewModel.sliderPadding)
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
                .padding(viewModel.sliderPadding)
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
                .padding(viewModel.sliderPadding)
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
            showingAlert = true
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
          .alert(Text(viewModel.victoryText), isPresented: $showingAlert) {
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

extension UILayouts {
  enum RGBGuessView {
    public static let sliderRange = 0.0...255.0
    public static let sliderVStackSpacing = 30.0
    public static let sliderTextFrameWidth = 40.0
    public static let sliderTextPadding = 5.0
    public static let sliderPadding = 10.0
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
