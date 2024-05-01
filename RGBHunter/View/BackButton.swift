import SwiftUI

struct BackButton: View {
  var body: some View {
    ZStack {
      RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
        .frame(width: 40, height: 40)
        .foregroundStyle(.black)
        .offset(x: -5, y: 5)
      RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
        .frame(width: 40, height: 40)
        .foregroundStyle(.pastelPurpleButton)
      Image(systemName: "arrowshape.left.fill")
        .foregroundStyle(.white)
    }
  }
}
