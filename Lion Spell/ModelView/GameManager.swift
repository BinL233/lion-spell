//
//  GameManager.swift
//  Lion Spell
//
//  Created by Kaile Ying on 9/3/23.
//

import Foundation

class GameManager : ObservableObject {
    let Spell = WordSpelling()
    
    var initWords : [String]
    var buttonNum : Int
    var languageWords : [String]
    var summary : [Int]
    var rotate : [Int]
    var offset : [Int]
    var rotatePen : [Int]
    var problemSizeChanged : Bool
    var wordsFound : [String]
    var wordslens : [Int:[String:Int]]
    @Published var currScore = 0
    @Published var foundWords : [String]
    @Published var currLetters : [String]
    @Published var currWord = ""
    @Published var isSubmitDisabled : Bool
    @Published var isDeleteDisabled : Bool
    @Published var totalNumWords : Int
    @Published var totalPossiblePoint : Int
    @Published var currLanguage : String
    @Published var pangramsNum : Int
    @Published var isSheetPresentedHint : Bool
    @Published var difficult : String
    @Published var isSheetPresentedPreference : Bool
    
    init() {
        buttonNum = Spell.initSpelling.initButtonNum
        languageWords = Spell.initSpelling.preference.language.language
        isDeleteDisabled = true
        isSubmitDisabled = true
        isSheetPresentedHint = false
        isSheetPresentedPreference = false
        problemSizeChanged = false
        foundWords = []
        rotate = Spell.initSpelling.rotate
        offset = Spell.initSpelling.offset
        rotatePen = Spell.initSpelling.rotatePen
        let localCurrLanguage = Spell.initSpelling.initLanguage
        difficult = Spell.initSpelling.difficult
        
        initWords = Spell.initSpelling.InitWordsGetter(buttonNum: buttonNum, language: localCurrLanguage)
        let localCurrLetters = Spell.initSpelling.Word2LettersArray(words: initWords, buttonNum: buttonNum)
        wordsFound = Spell.initSpelling.WordsFound(letters: localCurrLetters, language: localCurrLanguage)
        currLanguage = localCurrLanguage
        summary = Spell.initSpelling.SummaryCalc(words: wordsFound, letters: localCurrLetters)
        wordslens = Spell.initSpelling.WordsLenMatch(words: wordsFound)
        
        currLetters = localCurrLetters
        totalNumWords = summary[0]
        totalPossiblePoint = summary[1]
        pangramsNum = summary[2]
    }
    
    // When player enter letter
    private func EnterLetter(letter: String) {
        currWord += letter
        isDeleteDisabled = false
        if !foundWords.contains(currWord) && languageWords.contains(currWord) {
            isSubmitDisabled = false
        }
    }
    
    // When click submit button
    private func Submit() {
        if !foundWords.contains(currWord) && languageWords.contains(currWord) {
            if currWord.count == 4 {
                currScore += Spell.initSpelling.fourLetterWordScore
                foundWords.append(currWord)
                currWord = ""
            } else {
                currScore += currWord.count
            }
            
            var conta = 0
            for x in currLetters {
                if currWord.contains(x) {
                    conta += 1
                }
            }
            
            if conta == buttonNum {
                currScore += Spell.initSpelling.allLetterWordScore
            }
            
            foundWords.append(currWord)
            currWord = ""
            isSubmitDisabled = true
            isDeleteDisabled = true
        }
    }
    
    // Delete the last char
    private func Delete() {
        if currWord.count > 0 {
            currWord = String(currWord.dropLast())
        }
        if currWord.count == 0 {
            isDeleteDisabled = true
        }
    }
    
    // Restart a new game
    private func Restart() {
        problemSizeChanged = false
        currScore = 0
        foundWords = []
        if let value = Preferences.ProblemSize(rawValue: difficult) {
            buttonNum = value.size
        }
        initWords = Spell.initSpelling.InitWordsGetter(buttonNum: buttonNum, language: currLanguage)
        currLetters = Spell.initSpelling.Word2LettersArray(words: initWords, buttonNum: buttonNum)
        wordsFound = Spell.initSpelling.WordsFound(letters: currLetters, language: currLanguage)
        currWord = ""
        isSubmitDisabled = true
        isSubmitDisabled = true
        summary = Spell.initSpelling.SummaryCalc(words: wordsFound, letters: currLetters)
        wordslens = Spell.initSpelling.WordsLenMatch(words: wordsFound)
        totalNumWords = summary[0]
        totalPossiblePoint = summary[1]
        pangramsNum = summary[2]
    }
    
    // Shuffle the letters provided
    private func Shuffle() {
        currLetters = [currLetters[0]] + currLetters[1...currLetters.count-1].shuffled()
        currWord = ""
        isSubmitDisabled = true
        isSubmitDisabled = true
    }
    
    func ButtonSubmit() {
        Submit()
        Shuffle()
    }
    
    func ButtonDelete() {
        Delete()
    }
    
    func ButtonEnterLetter(letter: String) {
        EnterLetter(letter: letter)
    }
    
    func ButtonRestart() {
        Restart()
    }
    
    func ButtonShuffle() {
        Shuffle()
    }
    
}
