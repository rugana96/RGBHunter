import SwiftUI

struct MenuButton: View {
  private let buttonText: String
  
  public init(
    buttonText: String
  ) {
    self.buttonText = buttonText
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(
        cornerSize: CGSize(
          width: UILayouts.MenuButton.shadowCornerSize,
          height: UILayouts.MenuButton.shadowCornerSize
        )
      )
      .stroke(Color.black, lineWidth: UILayouts.MenuButton.shadowStrokeLineWidth)
      .fill(Color.black)
      .frame(width: UILayouts.MenuButton.shadowFrameWidth, height: UILayouts.MenuButton.shadowFrameHeighth)
      .offset(x: UILayouts.MenuButton.shadowOffsetX, y: UILayouts.MenuButton.shadowOffsetY)
      RoundedRectangle(
        cornerSize: CGSize(
          width: UILayouts.MenuButton.buttonCornerSize,
          height:  UILayouts.MenuButton.buttonCornerSize
        )
      )
        .stroke(Color.black, lineWidth:  UILayouts.MenuButton.buttonStrokeLineWidth)
        .fill(.pastelPurpleButton)
        .frame(width: UILayouts.MenuButton.buttonFrameWidth, height: UILayouts.MenuButton.buttonFrameHeighth)
      Text(buttonText)
        .font(.title2)
        .foregroundStyle(.white)
        .bold()
    }
  }
}

extension UILayouts {
  enum MenuButton {
    public static let shadowOffsetX = -5.0
    public static let shadowOffsetY = 5.0
    public static let shadowCornerSize = 10.0
    public static let shadowStrokeLineWidth = 3.0
    public static let shadowFrameWidth = 250.0
    public static let shadowFrameHeighth = 70.0
    public static let buttonCornerSize = 10.0
    public static let buttonFrameWidth = 250.0
    public static let buttonFrameHeighth = 70.0
    public static let buttonStrokeLineWidth = 3.0
  }
}
