import UIKit

struct Person: Codable {
  let name: String
  let age: Int
  let relations: [String : String]
}

let p1 = Person(name: "nancy", age: 26, relations: ["mum" : "Lucy", "dad" : "Peter"])

let encoder = JSONEncoder()
let data = try! encoder.encode(p1)

let jsonString = String(bytes: data, encoding: .utf8)

let decoder = JSONDecoder()
try! decoder.decode(Person.self, from: data)

