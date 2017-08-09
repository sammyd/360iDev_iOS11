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
import CoreML

func getLanguage(text: String) -> String? {
  //To be replaced
  return nil
}

func getSearchTerms(text: String, block: (String) -> Void) {
  // To be replaced
}

func getPeopleNames(text: String, block: (String) -> Void) {
  //To be replaced
}

func predictSentiment(text: String) -> Int? {
  // To be replaced
  return nil
}

func tokenizeAndCountWords(text: String) -> [Int] {
   // To be replaced
  return []
}

private let words = ["Austria", "Billy", "Chris", "Doctor", "Ellie", "I", "IDE", "Ms.", "Ning", "No", "Tiberius", "Xcode", "a", "all", "along", "also", "and", "annoy", "anything", "apocalypse", "aspiration", "at", "awful", "back", "background", "bad", "band", "be", "become", "believe", "better", "between", "big", "boo", "boring", "boy", "bug", "burger", "but", "by", "caffè", "can", "classic", "come", "confront", "contentious", "control", "crash", "cure", "dance", "dancing", "deadlock", "deadly", "die", "director", "disease", "do", "dragon", "dropping", "duet", "even", "eventually", "everything", "fabled", "famous", "fight", "film", "find", "finish", "fire", "follow", "for", "forget", "four", "from", "generation", "get", "go", "good", "great", "hah", "hat", "have", "he", "heartthrob", "hold", "horrible", "hour", "how", "iPhone", "ides", "in", "into", "involve", "it", "jaw", "joint", "joke", "journey", "keep", "killer", "leader", "learn", "legend", "life", "like", "literally", "little", "local", "lose", "loser", "loud", "love", "machine", "magnificent", "make", "many", "minus", "model", "money", "more", "most", "movie", "music", "need", "never", "nib", "night", "nil", "not", "now", "of", "oh", "on", "only", "oompah", "optional", "philosopher", "plague", "plot", "popular", "pretty", "punch", "really", "ride", "robot", "rule", "see", "service", "set", "show", "sing", "so", "spend", "star", "stop", "story", "straight", "stuff", "superb", "than", "that", "the", "there", "they", "thing", "think", "this", "three", "thrill", "through", "thumb", "time", "to", "total", "truly", "up", "use", "want", "watchdog", "way", "western", "what", "who", "why", "ya", "you", "young", "zombie"]
