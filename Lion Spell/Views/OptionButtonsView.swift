//
//  OptionButtonsView.swift
//  Lion Spell
//
//  Created by Kaile Ying on 8/26/23.
//

import SwiftUI

struct OptionButtonsView: View {
    @EnvironmentObject var gameManager : GameManager

    var body: some View {
        HStack {
            //Shuffle the letters
            Button(action: {gameManager.ButtonShuffle()}) {
                Image(systemName: "tornado")
            }
            .buttonStyle(.borderedProminent)
            Spacer()
            
            //Generate a new game
            Button(action: {gameManager.ButtonRestart()}) {
                Image(systemName: "plus")
            }
            .buttonStyle(.borderedProminent)
            Spacer()
            
            //Display hints
            Button(action: {gameManager.isSheetPresentedHint.toggle()}) {
                Image(systemName: "exclamationmark.bubble")
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $gameManager.isSheetPresentedHint) {
                NavigationView {
                    Form {
                        Section(header: Text("SUMMARY")) {
                            Text("Total number of words: \(gameManager.totalNumWords)")
                            Text("Total possible points: \(gameManager.totalPossiblePoint)")
                            Text("Number of Pangrams: \(gameManager.pangramsNum)")
                        }
                        
                        ForEach(gameManager.wordslens.sorted(by: { $0.key < $1.key }), id: \.key) { len, pc in
                            Section(header: Text("WORDS OF LENGTH: \(len)")) {
                                ForEach(pc.sorted(by: { $0.key < $1.key }), id: \.key) { initial, count in
                                    Text("\(initial): \(count)")
                                }
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Dismiss") {
                                gameManager.isSheetPresentedHint.toggle()
                            }
                        }
                    }
                }
            }
            Spacer()
            
            //Show preferences
            Button(action: {gameManager.isSheetPresentedPreference.toggle()}) {
                Image(systemName: "text.bubble")
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $gameManager.isSheetPresentedPreference) {
                NavigationView {
                    Form {
                        Section(header: Text("DIFFICULTY LEVEL")) {
                            Picker("DIFFICULTY LEVEL", selection: $gameManager.difficult) {
                                ForEach(Preferences.ProblemSize.allCases) { problemSize in
                                    Text(problemSize.rawValue).tag(Optional(problemSize))
                                }
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: gameManager.difficult, perform: { _ in
                                gameManager.ButtonRestart()
                            })
                        }
                        
                        Section(header: Text("LANGUAGE")) {
                            Picker("LANGUAGE", selection: $gameManager.currLanguage) {
                                ForEach(Preferences.Language.allCases) { language in
                                    Text(language.rawValue).tag(Optional(language))
                                }
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: gameManager.currLanguage, perform: { _ in
                                gameManager.ButtonRestart()
                            })
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Dismiss") {
                                gameManager.isSheetPresentedPreference.toggle()
                            }
                        }
                    }
                }
            }
        }
        .padding(24)
    }
}
