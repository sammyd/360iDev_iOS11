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
  return NSLinguisticTagger.dominantLanguage(for: text)
}

func getSearchTerms(text: String, language: String? = .none, block: (String) -> Void) {
  let tagger = NSLinguisticTagger(tagSchemes: [.lemma], options: 0)
  tagger.string = text
  
  let options: NSLinguisticTagger.Options = [.omitWhitespace,
                                             .omitPunctuation,
                                             .omitOther,
                                             .joinNames]
  
  let range = NSRange(text.startIndex..., in: text)
  if let language = language {
    tagger.setOrthography(NSOrthography.defaultOrthography(forLanguage: language), range: range)
  }
  
  tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) { (tag, tokenRange, _) in
    guard let tag = tag else { return }
    block(tag.rawValue.lowercased())
  }
}

func getPeopleNames(text: String, block: (String) -> Void) {
  let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
  tagger.string = text
  
  let options: NSLinguisticTagger.Options = [.omitWhitespace,
                                             .omitOther,
                                             .omitPunctuation,
                                             .joinNames]
  let range = NSRange(text.startIndex..., in: text)
  
  tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { (tag, tokenRange, _) in
    guard let tag = tag,
      tag == .personalName else { return }
    
    let token = Range(tokenRange, in: text)!
    block(String(text[token]))
  }
}

func predictSentiment(text: String) -> Int? {
  let counts = tokenizeAndCountWords(text: text)
  
  let model = Sentiment()
  let input = try! MLMultiArray(shape: [1, NSNumber(value: words.count)], dataType: .int32)
  
  for (index, counts) in counts.enumerated() {
    input[index] = NSNumber(value: counts)
  }
  let prediction = try! model.prediction(wordCount: input)
  let sentiment = prediction.sentiment
  
  return Int(sentiment)
}

func tokenizeAndCountWords(text: String) -> [Int] {
  let tagger = NSLinguisticTagger(tagSchemes: [.lemma, .lexicalClass], options: 0)
  tagger.string = text
  let options: NSLinguisticTagger.Options = [.omitWhitespace,
                                             .omitPunctuation,
                                             .omitOther,
                                             .joinNames]
  let range = NSRange(text.startIndex..., in: text)
  var wordCount = Array(repeating: 0, count: words.count)
  tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) { (tag, _, _) in
    guard let tag = tag else { return }
    let word = tag.rawValue
    
    if let index = words.index(of: word) {
      wordCount[index] += 1
    }
  }
  return wordCount
}

private let words = ["Austria", "Billy", "Chris", "Doctor", "Ellie", "I", "IDE", "Ms.", "Ning", "No", "Tiberius", "Xcode", "a", "all", "along", "also", "and", "annoy", "anything", "apocalypse", "aspiration", "at", "awful", "back", "background", "bad", "band", "be", "become", "believe", "better", "between", "big", "boo", "boring", "boy", "bug", "burger", "but", "by", "caffè", "can", "classic", "come", "confront", "contentious", "control", "crash", "cure", "dance", "dancing", "deadlock", "deadly", "die", "director", "disease", "do", "dragon", "dropping", "duet", "even", "eventually", "everything", "fabled", "famous", "fight", "film", "find", "finish", "fire", "follow", "for", "forget", "four", "from", "generation", "get", "go", "good", "great", "hah", "hat", "have", "he", "heartthrob", "hold", "horrible", "hour", "how", "iPhone", "ides", "in", "into", "involve", "it", "jaw", "joint", "joke", "journey", "keep", "killer", "leader", "learn", "legend", "life", "like", "literally", "little", "local", "lose", "loser", "loud", "love", "machine", "magnificent", "make", "many", "minus", "model", "money", "more", "most", "movie", "music", "need", "never", "nib", "night", "nil", "not", "now", "of", "oh", "on", "only", "oompah", "optional", "philosopher", "plague", "plot", "popular", "pretty", "punch", "really", "ride", "robot", "rule", "see", "service", "set", "show", "sing", "so", "spend", "star", "stop", "story", "straight", "stuff", "superb", "than", "that", "the", "there", "they", "thing", "think", "this", "three", "thrill", "through", "thumb", "time", "to", "total", "truly", "up", "use", "want", "watchdog", "way", "western", "what", "who", "why", "ya", "you", "young", "zombie"]
