//
//  UserTextView.swift
//  Lion Spell
//
//  Created by Kaile Ying on 8/26/23.
//

import SwiftUI

struct UserTextView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.title)
            .kerning(ViewConstants().userTextKerning)
    }
}
