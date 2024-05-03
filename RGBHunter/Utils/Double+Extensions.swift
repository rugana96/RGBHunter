import Foundation

extension Double {
  func tosRGB() -> Double {
    (self / 255).round(to: 2)
  }
}

extension Double {
  func round(to places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
