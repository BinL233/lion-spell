//
//  InitLettersGetter.swift
//  Lion Spell
//
//  Created by Kaile Ying on 9/3/23.
//

import Foundation

struct InitWords {
    func InitWordsGetter() -> [String] {
        var initWords : [String] = []
        let arr = Words.englishWords.filter { $0.count == 5 } // Filt words to get 5 letter words
        
        for x in arr {
            let set = Set(x)
            if set.count == 5 {
                initWords.append(x)
            }
        }
        
        return initWords
    }
}
