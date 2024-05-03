import SwiftUI

struct InfoButton: View {
  @State private var viewModel = InfoButton.ViewModel()
  
  var body: some View {
    Button {
      viewModel.isInfoModalPresented = true
    } label: {
      Image(systemName: UILayouts.InfoButton.infoImageSystemName)
        .resizable()
        .frame(width: UILayouts.InfoButton.infoImageFrame, height: UILayouts.InfoButton.infoImageFrame)
        .foregroundStyle(.black)
        .padding()
    }
    .sheet(isPresented: $viewModel.isInfoModalPresented) {
      InfoView()
    }
  }
}

extension UILayouts {
  enum InfoButton {
    public static let infoImageSystemName = "info.circle"
    public static let infoImageFrame = 25.0
  }
}

extension InfoButton {
  @Observable final class ViewModel {
    var isInfoModalPresented = false
  }
}
