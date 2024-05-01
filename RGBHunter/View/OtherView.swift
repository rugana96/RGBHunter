import SwiftUI

struct OtherDifficultyView: View {
  var body: some View {
    VStack {
      NavigationLink("Normal") {
        Text("Normal Other Game")
      }
      Spacer()
      NavigationLink("Difficult") {
        Text("Difficult Other Game")
      }
    }
    
  }
}
