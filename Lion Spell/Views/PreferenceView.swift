//
//  PreferenceHintView.swift
//  Lion Spell
//
//  Created by Kaile Ying on 9/11/23.
//

import SwiftUI

struct PreferenceView : View{

    
    var body: some View {
        .sheet(isPresented: $isSheetPresented) {
            Form {
                Section(header: Text("SUMMARY")) {
                    Picker("Total number of words: ", selection: $buttonNum) {
                        Text("")
                    }
                }
            }
        }
    }
}
