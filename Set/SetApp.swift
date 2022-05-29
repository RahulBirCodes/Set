//
//  SetApp.swift
//  Set
//
//  Created by Rahul Bir on 5/26/22.
//

import SwiftUI

@main
struct SetApp: App {
    private let viewModel = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            SetGameView(setGame: viewModel)
        }
    }
}
