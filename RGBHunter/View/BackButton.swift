import SwiftUI

struct BackButton: View {
  private var viewModel: BackButton.ViewModel = BackButton.ViewModel()
  var body: some View {
    ZStack {
      RoundedRectangle(
        cornerSize: CGSize(
          width: UILayouts.BackButton.shadowCornerSize,
          height: UILayouts.BackButton.shadowCornerSize
        )
      )
      .stroke(Color.black, lineWidth: UILayouts.BackButton.shadowStrokeLineWidth)
      .fill(Color.black)
      .frame(width: UILayouts.BackButton.shadowFrame, height: UILayouts.BackButton.shadowFrame)
      .offset(x: UILayouts.BackButton.shadowOffsetX, y: UILayouts.BackButton.shadowOffsetY)
      RoundedRectangle(
        cornerSize: CGSize(
          width: UILayouts.BackButton.buttonCornerSize,
          height: UILayouts.BackButton.buttonCornerSize
        )
      )
      .stroke(Color.black, lineWidth: UILayouts.BackButton.buttonStrokeLineWidth)
      .fill(.pastelPurpleButton)
      .frame(width: UILayouts.BackButton.buttonFrame, height: UILayouts.BackButton.buttonFrame)
      Image(systemName: viewModel.arrowImageSystemName)
        .foregroundStyle(.white)
    }
  }
}

extension UILayouts {
  enum BackButton {
    public static let buttonFrame = 40.0
    public static let buttonCornerSize = 10.0
    public static let buttonStrokeLineWidth = 2.0
    public static let shadowFrame = 40.0
    public static let shadowCornerSize = 10.0
    public static let shadowStrokeLineWidth = 2.0
    public static let shadowOffsetX = -3.0
    public static let shadowOffsetY = 3.0
  }
}

extension BackButton {
  final class ViewModel {
    let arrowImageSystemName = "arrowshape.left.fill"
  }
}

