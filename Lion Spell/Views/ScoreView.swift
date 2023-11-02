//
//  ScoreView.swift
//  Lion Spell
//
//  Created by Kaile Ying on 8/26/23.
//

import SwiftUI

struct ScoreView: View {
    let score: Int
    var body: some View {
        Text("\(score)")
            .font(.title)
            .bold()
    }
}
