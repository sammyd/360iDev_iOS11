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

import UIKit

class BugCell: UICollectionViewCell {
  
  @IBOutlet private var container: UIView!
  @IBOutlet private var idLabel: UILabel!
  @IBOutlet private var label: UILabel!
  @IBOutlet private var bugIcon: UIImageView!
  
  var bug: Bug? {
    didSet {
      guard let bug = bug else { return }
      idLabel.text = bug.id
      label.text = bug.label
      bugIcon.tintColor = tintColorFor(priority: bug.priority)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureBorder()
  }
  
  private func configureBorder() {
    container.layer.borderWidth = 1
    container.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
    container.layer.cornerRadius = 3
  }
  
  private func tintColorFor(priority: Bug.Priority) -> UIColor {
    switch priority {
    case .low:
      return UIColor.init(named: "Low")!
    case .medium:
      return UIColor.init(named: "Medium")!
    case .high:
      return UIColor.init(named: "High")!
    }
  }
}
