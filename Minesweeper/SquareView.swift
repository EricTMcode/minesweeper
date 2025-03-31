//
//  SquareView.swift
//  Minesweeper
//
//  Created by Eric on 31/03/2025.
//

import SwiftUI

struct SquareView: View {
    var square: Square

    var color: Color {
        if square.isRevealed {
            .gray.opacity(0.2)
        } else {
            .gray
        }
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(color.gradient)

            if square.isRevealed {
                if square.hasMine {
                    Text("💥")
                        .font(.system(size: 48))
                        .shadow(color: .red, radius: 1)
                } else if square.nearbyMines > 0 {
                    Text(String(square.nearbyMines))
                }
            } else if square.isFlagged {
                Image(systemName: "exclationmark.triangle.fill")
                    .foregroundStyle(.black, .yellow)
                    .shadow(color: .black, radius: 3)
            }
        }
        .frame(width: 60, height: 60)
    }
}

#Preview {
    SquareView(square: Square(row: 0, column: 0))
}
