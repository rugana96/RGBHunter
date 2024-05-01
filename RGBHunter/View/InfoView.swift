import SwiftUI

struct InfoView: View {
  let infoTitle: String
  let infoTextOne: String
  let infoTextTwo: String
  let infoTextThree: String
  let infoTextFour: String
  let infoTextDifficult: String
  
  @State var redSlider: Double = .zero
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      Image(.background)
        .resizable()
        .edgesIgnoringSafeArea(.all)
        .opacity(0.2)
      VStack {
        ZStack {
          Text(infoTitle)
            .bold()
            .font(.title2)
          HStack {
            Button {
              dismiss()
            } label: {
              Image(systemName: "xmark.circle")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(.black)
                .padding()
            }
            Spacer()
          }
        }
        Text(infoTextOne)
          .padding()
        Text(infoTextTwo)
          .padding()
        HStack {
          Text("R")
            .padding(5)
            .bold()
          Slider(value: $redSlider, in: 0...255)
            .tint(Color.red)
          Text(String(redSlider.tosRGB()))
            .frame(width: 40)
            .bold()
        }
        .padding()
        Text(infoTextThree)
          .padding()
        Circle()
          .stroke(.black, lineWidth: 2)
          .fill(.green)
          .frame(width: 35)
          .overlay {
            Image(systemName: "checkmark")
              .foregroundStyle(.white)
          }
        Text(infoTextFour)
          .padding()
        VStack(alignment: .leading) {
          Text("* 0 - 99: Not even close.")
          Text("* 100 - 199: Close, not there.")
          Text("* 200 - 299: Really close.")
          Text("* 300: Perfect score.")
        }
        VStack(alignment: .leading) {
          Text("NOTE:")
            .bold()
          Text(infoTextDifficult)
        }
        .padding()
      }
    }
  }
}

#Preview {
  InfoView(
    infoTitle: "How to play",
    infoTextOne: "A random color will appear in the circle on the right.",
    infoTextTwo: "You will have to move the sliders to get the same color in the circle on the right.",
    infoTextThree: "Once you think you have it press the green button to submit your values.",
    infoTextFour: "Depending on how far you are from the random color you will get a score:",
    infoTextDifficult: "In difficult mode you will only have 5 seconds to see the random color. No slider feedback will be shown."
  )
}
