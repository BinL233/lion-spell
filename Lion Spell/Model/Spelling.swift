//
//  Spelling.swift
//  Lion Spell
//
//  Created by Kaile Ying on 9/3/23.
//

import Foundation

struct WordScramble {
    let initButtonNum : Int
    let difficult : String
    let currLetters : [String] // The current letters which show on buttons
    let initWords : [String] // The filtered words
    let preference : Preferences
    let initLanguage : String
    let isSheetPresentedPreference : Bool
    let isSheetPresentedHint : Bool
    let rotate : [Int]
    let rotatePen : [Int]
    let offset : [Int]
}

struct Preferences {
    let language: Language
    let problemSize: ProblemSize
}

struct WordSpelling : Spelling {
    let initSpelling = WordScramble(initButtonNum: 5, difficult: "5", currLetters: [], initWords: [], preference: Preferences(language: .english, problemSize: .five), initLanguage: "English", isSheetPresentedPreference: false, isSheetPresentedHint: false, rotate: [0, 0, 30], rotatePen: [0, 36, 0], offset: [0, 18, 30])
}

protocol Spelling {
    var initSpelling : WordScramble {get}
}

extension WordScramble {
    // The scores of different kinds of words
    var fourLetterWordScore : Int {1}
    //var moreLetterWordScore : Int {initButtonNum.currWord.count}
    var allLetterWordScore : Int {10}
    
    func InitWordsGetter(buttonNum: Int, language: String) -> [String] {
        var languageWords : [String] = []
        if let languageL = Preferences.Language(rawValue: language) {
            languageWords = languageL.language
        } else {
            return languageWords
        }
        var initWords : [String] = []
        let arr = languageWords.filter { $0.count >= buttonNum } // Filt words to get words which larger than 5

        for x in arr {
            let set = Set(x)
            if set.count == buttonNum {
                initWords.append(String(set))
            }
        }

        return initWords
    }

    func Word2LettersArray(words: [String], buttonNum: Int) -> [String] {
        var charArr : [String] = []
        let word : String = words[Int.random(in: 0...words.count-1)] // Get the random word with random indexes
        var index = 0

        for char in word {
            if index > buttonNum-1 {
                break
            }
            charArr.append(String(char))
            index += 1
        }

        return charArr.shuffled()
    }
    
    func WordsFound(letters: [String], language: String) -> [String] {
        var languageWords : [String] = []
        var output : [String] = []
        if let languageL = Preferences.Language(rawValue: language) {
            languageWords = languageL.language
        }
        
        for x in languageWords {
            let setX = Set(x)
            if setX.count <= letters.count {
                var count = 0
                for y in setX {
                    if !letters.contains(String(y)) {
                        break
                    } else {
                        count += 1
                    }
                    
                    if count == setX.count {
                        output.append(x)
                    }
                }
            }
        }
        
        return output
        
    }
    
    func SummaryCalc(words: [String], letters: [String]) -> [Int] {
        var output : [Int] = []
        var possiblePoint : Int = 0
        var totalWords : Int = 0
        var pangrams : Int = 0
        
        for x in words {
            let word = x
            totalWords += 1
            
            if word.count == 4 {
                possiblePoint += fourLetterWordScore
            } else {
                possiblePoint += word.count
            }
            
            var conta = 0
            for z in letters {
                if word.contains(z) {
                    conta += 1
                }
            }
            
            if conta == letters.count {
                possiblePoint += allLetterWordScore
                pangrams += 1
            }
        }
        output.append(totalWords)
        output.append(possiblePoint)
        output.append(pangrams)
        return output
    }
    
    func WordsLenArr(match: [Int:[String:Int]]) -> [Int] {
        var output : [Int] = []
        for length in match.keys.sorted(by: { $0 < $1 }) {
            output.append(length)
        }
        return output
    }
    
    func WordsLenMatch(words: [String]) -> [Int:[String:Int]] {
        var output: [Int: [String: Int]] = [:]
        for x in words {
            let length = x.count
            guard let firstChar = x.first else { continue }
            let initial = String(firstChar)
            if output[length] == nil {
                output[length] = [:]
            }
            output[length]?[initial, default: 0] += 1
        }
        
        return output
    }
}

extension Preferences {
    enum Language: String, CaseIterable, Identifiable {
        case english = "English"
        case french = "French"
        case german = "German"
        case italian = "Italian"
        
        var id: String {
            self.rawValue
        }
        
        var language: [String] {
            switch self {
            case .english:
                return Words.englishWords
            case .french:
                return Words.frenchWords
            case .german:
                return Words.germanWords
            case .italian:
                return Words.italianWords
            }
        }
    }
    
    enum ProblemSize: String, CaseIterable, Identifiable {
        case five = "5"
        case six = "6"
        case seven = "7"
        
        var id: String {
            self.rawValue
        }
        
        var size: Int {
            switch self {
            case .five:
                return 5
            case .six:
                return 6
            case .seven:
                return 7
            }
        }
    }
}
