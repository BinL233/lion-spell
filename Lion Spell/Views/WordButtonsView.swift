//
//  WoedButtonsView.swift
//  Lion Spell
//
//  Created by Kaile Ying on 8/26/23.
//

import SwiftUI

struct WordButtonsView: View {
    @EnvironmentObject var gameManager : GameManager
    let radius = 100
    var body: some View {
        Spacer()
        ZStack {
            ForEach(0..<gameManager.currLetters.count-1, id: \.self) {i in
                let currLetter = gameManager.currLetters[i+1]
                let angle = CGFloat(i) * 2 * CGFloat.pi / CGFloat(gameManager.buttonNum - 1) - (2 * CGFloat.pi / CGFloat(gameManager.buttonNum - 1) / 2) -  (CGFloat(gameManager.offset[gameManager.buttonNum-5]) / 360 * 2 * .pi)
                ZStack {
                    Button(action: {gameManager.ButtonEnterLetter(letter: currLetter)}) {
                        Text(currLetter)
                            .font(.title)
                            .rotationEffect(Angle(degrees: CGFloat(-1 * gameManager.rotate[gameManager.buttonNum - 5])))
                            .rotationEffect(Angle(degrees: CGFloat(-1 * gameManager.rotatePen[gameManager.buttonNum - 5])))
                            .background(Shapes(side: gameManager.buttonNum).fill(.gray).frame(width: 100, height: 100))
                            .frame(width: 100, height: 100)
                            //.offset(x: CGFloat(radius) * cos(angle), y: CGFloat(radius) * sin(angle))
                    }
                    .rotationEffect(Angle(degrees: CGFloat(gameManager.rotatePen[gameManager.buttonNum - 5])))
                    .offset(x: CGFloat(radius) * cos(angle), y: CGFloat(radius) * sin(angle))
                    .rotationEffect(Angle(degrees: CGFloat(gameManager.rotate[gameManager.buttonNum - 5])))
                }
            }
            Button(action: {gameManager.ButtonEnterLetter(letter: gameManager.currLetters[0])}) {
                Text(gameManager.currLetters[0])
                    .font(.title)
                    .rotationEffect(Angle(degrees: CGFloat(-1 * gameManager.rotate[gameManager.buttonNum - 5])))
                    .background(Shapes(side: gameManager.buttonNum).fill(.yellow).frame(width: 100, height: 100))
                    .frame(width: 100, height: 100)
            }
            .rotationEffect(Angle(degrees: CGFloat(gameManager.rotate[gameManager.buttonNum - 5])))
        }
    Spacer()
    
    }
}
