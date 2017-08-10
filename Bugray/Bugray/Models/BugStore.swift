/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

class BugStore: Codable {
  
  static let sharedStore: BugStore = {
    var store = BugStore.emptyStore()
    if let url = Bundle.main.url(forResource: "bugs", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        store = try JSONDecoder().decode(BugStore.self, from: data)
      } catch let error {
        print(error)
      }
    }
    return store
  }()
  
  private var store: [Bug.Context: [Bug]]
  
  class func emptyStore() -> BugStore {
    let label = "It appears as though the JSON bug store failed to load. You might want to check that!"
    let store: [Bug.Context: [Bug]] = [
      .toDo: [Bug(id: "WEB-001", label: label, context: .toDo)],
      .inProgress: [Bug(id: "WEB-002", label: label, context: .inProgress)],
      .done: [Bug(id: "WEB-003", label: label, context: .done)]
    ]
    return BugStore(store: store)
  }
  
  init(store: [Bug.Context: [Bug]]) {
    self.store = store
  }
  
  func bugs(for context: Bug.Context) -> [Bug] {
    return store[context]!
  }
  
  func bug(at index: Int, in context: Bug.Context) -> Bug {
    return bugs(for: context)[index]
  }
  
  func insert(bugs: [Bug], into context: Bug.Context, at index: Int) {
    store[context]!.insert(contentsOf: bugs, at: index)
    bugs.forEach { $0.context = context }
  }
  
  func deleteBugs(at indexes: [Int], in context: Bug.Context) -> [Bug] {
    let plucked = bugs(for: context)
      .enumerated()
      .filter({ indexes.contains($0.offset) })
      .map { $0.element }
    store[context] = bugs(for: context)
      .enumerated()
      .filter({ !indexes.contains($0.offset) })
      .map { $0.element }
    return plucked
  }
}
