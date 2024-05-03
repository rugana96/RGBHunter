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
      .frame(width: UILayouts.BackButton.shadowFrame, height: UILayouts.BackButton.shadowFrame)
      .foregroundStyle(.black)
      .offset(x: UILayouts.BackButton.shadowOffsetX, y: UILayouts.BackButton.shadowOffsetY)
      RoundedRectangle(
        cornerSize: CGSize(
          width: UILayouts.BackButton.buttonCornerSize,
          height: UILayouts.BackButton.buttonCornerSize
        )
      )
      .frame(width: UILayouts.BackButton.buttonFrame, height: UILayouts.BackButton.buttonFrame)
      .foregroundStyle(.pastelPurpleButton)
      Image(systemName: viewModel.arrowImageSystemName)
        .foregroundStyle(.white)
    }
  }
}

extension UILayouts {
  enum BackButton {
    public static let buttonFrame = 40.0
    public static let buttonCornerSize = 10.0
    public static let shadowFrame = 40.0
    public static let shadowCornerSize = 10.0
    public static let shadowOffsetX = -5.0
    public static let shadowOffsetY = 5.0
  }
}

extension BackButton {
  final class ViewModel {
    let arrowImageSystemName = "arrowshape.left.fill"
  }
}

