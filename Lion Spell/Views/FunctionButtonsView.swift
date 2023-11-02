//
//  FunctionButtonsView.swift
//  Lion Spell
//
//  Created by Kaile Ying on 8/26/23.
//

import SwiftUI

struct FunctionButtonsView: View {
    @EnvironmentObject var gameManager : GameManager
    var body: some View {
        HStack {
            DeleteButtonView()
            Spacer()
            SubmitButtonView()
        }
        .padding(20)
    }
}
