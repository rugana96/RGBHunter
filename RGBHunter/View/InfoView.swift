import SwiftUI

struct InfoView: View {
  @State private var viewModel: InfoView.ViewModel = InfoView.ViewModel()
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    VStack {
      ZStack {
        Text(viewModel.infoTitle)
          .bold()
          .font(.title2)
        HStack {
          Button {
            dismiss()
          } label: {
            Image(systemName: viewModel.closeImageSystemName)
              .resizable()
              .frame(width: UILayouts.InfoView.closeImageFrame, height: UILayouts.InfoView.closeImageFrame)
              .foregroundStyle(.black)
              .padding()
          }
          Spacer()
        }
      }
      Divider()
      ScrollView {
        ZStack {
          VStack {
            Text(viewModel.infoTextOne)
              .padding()
            Text(viewModel.infoTextTwo)
              .padding()
            HStack {
              Text(viewModel.R)
                .padding(UILayouts.InfoView.sliderTextPadding)
                .bold()
              Slider(value: $viewModel.redSlider, in: UILayouts.InfoView.sliderRange)
                .tint(Color.red)
              Text(String(viewModel.redSlider.tosRGB()))
                .frame(width: UILayouts.InfoView.sliderTextFrameWidth)
                .bold()
            }
            .padding()
            Text(viewModel.infoTextThree)
              .padding()
            Circle()
              .stroke(.black, lineWidth: UILayouts.InfoView.circleStrokeLineWidth)
              .fill(.green)
              .frame(width: UILayouts.InfoView.circleFrameWidth)
              .overlay {
                Image(systemName: viewModel.checkMarkImageSystemName)
                  .foregroundStyle(.white)
              }
            Text(viewModel.infoTextFour)
              .padding()
            VStack(alignment: .leading) {
              Text(viewModel.scoreOne)
              Text(viewModel.scoreTwo)
              Text(viewModel.scoreThree)
              Text(viewModel.scorteFour)
            }
            VStack(alignment: .leading) {
              Text(viewModel.note)
                .bold()
              Text(viewModel.infoTextDifficult)
            }
            .padding()
          }
        }
      }
    }
    .background(
      Image(.background)
        .resizable()
        .edgesIgnoringSafeArea(.all)
        .opacity(UILayouts.InfoView.backgroundImageOpacity)
    )
  }
}

extension UILayouts {
  enum InfoView {
    public static let backgroundImageOpacity = 0.2
    public static let circleFrameWidth = 35.0
    public static let circleStrokeLineWidth = 2.0
    public static let sliderTextFrameWidth = 40.0
    public static let sliderTextPadding = 5.0
    public static let sliderRange = 0.0...255.0
    public static let closeImageFrame = 25.0
  }
}

extension InfoView {
  @Observable final class ViewModel {
    var redSlider: Double = .zero
    let infoTitle: String = String(localized: "infoTitle")
    let infoTextOne: String = String(localized: "infoTextOne")
    let infoTextTwo: String = String(localized: "infoTextTwo")
    let infoTextThree: String = String(localized: "infoTextThree")
    let infoTextFour: String = String(localized: "infoTextFour")
    let infoTextDifficult: String = String(localized: "infoTextDifficult")
    let R: String = String(localized: "R")
    let scoreOne: String = String(localized: "scoreOne")
    let scoreTwo: String = String(localized: "scoreTwo")
    let scoreThree: String = String(localized: "scoreThree")
    let scorteFour: String = String(localized: "scoreFour")
    let note: String = String(localized: "scoreNote")
    let checkMarkImageSystemName: String = "checkmark"
    let closeImageSystemName: String = "xmark.circle"
  }
}
