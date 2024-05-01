import SwiftUI

struct menuButton: View {
  let buttonText: String
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerSize: CGSize(width: 10.0, height: 10.0))
        .stroke(Color.black, lineWidth: 3.0)
        .fill(Color.black)
        .frame(width: 250, height: 70)
        .offset(x: -5, y: 5)
      RoundedRectangle(cornerSize: CGSize(width: 10.0, height: 10.0))
        .stroke(Color.black, lineWidth: 3.0)
        .fill(.pastelPurpleButton)
        .frame(width: 250, height: 70)
      Text(buttonText)
        .font(.title2)
        .foregroundStyle(.white)
        .bold()
    }
  }
}
