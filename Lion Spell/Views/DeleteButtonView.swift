//
//  DeleteButtonView.swift
//  Lion Spell
//
//  Created by Kaile Ying on 8/26/23.
//

import SwiftUI

struct DeleteButtonView: View {
    @EnvironmentObject var gameManager : GameManager
    var body: some View {
        Button(action: {gameManager.ButtonDelete()}) {
            Image(systemName: "delete.left")
                .font(.title2)
        }
        .disabled(gameManager.isDeleteDisabled)
    }
}
