import UIKit


struct Color: Codable {
  let red, green, blue, alpha: Float
}

struct Person: Codable {
  let name: String
  let age: Int
  let colors: [Color]
}

let p1 = Person(name: "nancy", age: 26, colors: [Color(red: 0.1, green: 0.4, blue: 1, alpha: 0.1)])

let encoder = JSONEncoder()
let data = try! encoder.encode(p1)

let jsonString = String(bytes: data, encoding: .utf8)

let decoder = JSONDecoder()
try! decoder.decode(Person.self, from: data)

