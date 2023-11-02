//
//  Lion_SpellApp.swift
//  Lion Spell
//
//  Created by Kaile Ying on 8/26/23.
//

import SwiftUI

@main
struct Lion_SpellApp: App {
    @StateObject var gameManager = GameManager()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(gameManager)
        }
    }
}
