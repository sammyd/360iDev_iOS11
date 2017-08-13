import UIKit


extension UIColor: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.unkeyedContainer()
    var color : (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) = (0, 0, 0, 0)
    getRed(&color.r, green: &color.g, blue: &color.b, alpha: &color.a)
    try container.encode(color.r)
    try container.encode(color.g)
    try container.encode(color.b)
    try container.encode(color.a)
  }
}



struct Person: Encodable {
  let name: String
  let age: Int
  let favouriteColour: UIColor
}

let p1 = Person(name: "nancy", age: 26, favouriteColour: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))

let encoder = JSONEncoder()
let data = try! encoder.encode(p1)

let jsonString = String(bytes: data, encoding: .utf8)

let decoder = JSONDecoder()
//try! decoder.decode(Person.self, from: data)

