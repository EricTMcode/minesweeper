//
//  GameOverView.swift
//  Minesweeper
//
//  Created by Eric on 01/04/2025.
//

import SwiftUI

struct GameOverView: View {
    var state: GameState
    var restart: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Group {
                if state == .won {
                    Text("You win!")
                } else {
                    Text("Bad luck!")
                }
            }
            .textCase(.uppercase)
            .font(.system(size: 60).weight(.black))
            .fontDesign(.rounded)
            .foregroundStyle(.white)

            Button(action: restart) {
                Text("Try Again")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .foregroundStyle(.white)
                    .background(.blue.gradient)
                    .clipShape(.rect(cornerRadius: 10))
            }
            .font(.title)
            .buttonStyle(.plain)
        }
        .transition(.scale(scale: 2).combined(with: .opacity))
        .padding(.vertical)
        .padding(.bottom, 5)
        .frame(maxWidth: .infinity)
        .background(.black.opacity(0.75).gradient)
    }
}

#Preview {
    GameOverView(state: .won, restart: {})
}
