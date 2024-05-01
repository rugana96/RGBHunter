import SwiftUI

struct InfoButton: View {
  @State private var isInfoModalPresented = false
  
  var body: some View {
    Button {
      isInfoModalPresented = true
    } label: {
      Image(systemName: "info.circle")
        .resizable()
        .frame(width: 25, height: 25)
        .foregroundStyle(.black)
        .padding()
    }
    .sheet(isPresented: $isInfoModalPresented) {
      InfoView(
        infoTitle: "How to play",
        infoTextOne: "A random color will appear in the circle on the right.",
        infoTextTwo: "You will have to move the sliders to get the same color in the circle on the right.",
        infoTextThree: "Once you think you have it press the green button to submit your values.",
        infoTextFour: "Depending on how far you are from the random color you will get a score:",
        infoTextDifficult: "In difficult mode you will only have 5 seconds to see the random color. No slider feedback will be shown."
      )
    }
  }
}
