//
//  RootView.swift
//  Lion Spell
//
//  Created by Kaile Ying on 8/26/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var gameManager : GameManager
    var body: some View {
        ZStack {
            Color.init(red: 0.85, green: 0.9, blue: 1).ignoresSafeArea()
            BackgroundView()
            VStack {
                TitleView()
                Spacer()
                ListWordView(textArray: gameManager.foundWords)
                UserTextView(text: gameManager.currWord)
                WordButtonsView()
                FunctionButtonsView()
                ScoreView(score: gameManager.currScore)
                OptionButtonsView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let gameManager = GameManager()
        RootView()
            .environmentObject(gameManager)
    }
}
