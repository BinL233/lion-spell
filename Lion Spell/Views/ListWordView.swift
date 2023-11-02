//
//  ListWordView.swift
//  Lion Spell
//
//  Created by Kaile Ying on 8/26/23.
//

import SwiftUI

struct ListWordView: View {
    let textArray: Array<String>
    var body: some View {
        ScrollView(.horizontal){
            HStack {
                ForEach(Array(textArray.indices), id: \.self) {i in
                    Text(textArray[i])
                        .font(.title2)
                }
            }
            .padding(10)
        }
        .background(Color.gray)
    }
}
