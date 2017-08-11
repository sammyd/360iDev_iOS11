/*
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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class BugDragCoordinator {
  let source: Bug.Context
  var sourceIndexPaths = [IndexPath]()
  var sourceIndexes: [Int] {
    return sourceIndexPaths.map { $0.item }
  }
  
  var destination: Bug.Context?
  var destinationIndexPaths: [IndexPath]?
  var dragCompleted = false
  
  var isReordering: Bool {
    guard let destination = destination else { return false }
    return source == destination
  }
  
  init(source: Bug.Context) {
    self.source = source
  }
  
  func dragItemForBugAt(indexPath: IndexPath) -> UIDragItem {
    sourceIndexPaths.append(indexPath)
    let bug = BugStore.sharedStore.bug(at: indexPath.item, in: source)
    let bugProvider = NSItemProvider(object: bug.label as NSString)
    return UIDragItem(itemProvider: bugProvider)
  }
  
  func calculateDestinationIndexPaths(from indexPath: IndexPath, count: Int) {
    let indexes = Array(indexPath.item ..< (indexPath.item + count))
    destinationIndexPaths = indexes.map { IndexPath(item: $0, section: 0) }
  }
}
