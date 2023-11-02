//
//  SubmitButtonView.swift
//  Lion Spell
//
//  Created by Kaile Ying on 8/26/23.
//

import SwiftUI

struct SubmitButtonView: View {
    @EnvironmentObject var gameManager : GameManager
    var body: some View {
        Button(action: {gameManager.ButtonSubmit()}) {
            Image(systemName: "paperplane")
                .foregroundColor(.green)
                .font(.title2)
        }
        .disabled(gameManager.isSubmitDisabled)
        .opacity(gameManager.isSubmitDisabled ? ViewConstants().submitButtonLowOpacity : ViewConstants().submitButtonFullOpacity)
    }
}
