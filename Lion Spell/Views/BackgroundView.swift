//
//  Background.swift
//  Lion Spell
//
//  Created by Kaile Ying on 9/4/23.
//

import SwiftUI

struct BackgroundView : View {
    var body: some View {
        Image("Maimai-Milk")
            .opacity(ViewConstants().bgImageOpacity)
            .offset(y: ViewConstants().bgImageYOffset)
    }
}
