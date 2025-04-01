//
//  ContentView.swift
//  Minesweeper
//
//  Created by Eric on 31/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var rows = [[Square]]()

    var allSquares: [Square] {
        rows.flatMap { $0 }
    }

    var body: some View {
        Grid(horizontalSpacing: 2, verticalSpacing: 2) {
            ForEach(0..<rows.count, id: \.self) { row in
                GridRow {
                    ForEach(rows[row]) { square in
                        SquareView(square: square)
                    }
                }
            }
        }
        .font(.largeTitle)
        .onAppear(perform: createGrid)
        .preferredColorScheme(.dark)
    }

    func createGrid() {
        rows.removeAll()

        for row in 0..<9 {
            var rowSquares = [Square]()

            for column in 0..<9 {
                let square = Square(row: row, column: column)
                rowSquares.append(square)
            }

            rows.append(rowSquares)
        }
    }

    func square(atRow row: Int, column: Int) -> Square? {
        if row < 0 { return nil }
        if row >= rows.count { return nil }
        if column < 0 { return nil }
        if column >= rows[row].count { return nil }
        return rows[row][column]
    }

    func getAdjacentSquares(toRow row: Int, column: Int) -> [Square] {
        var result = [Square?]()

        result.append(square(atRow: row - 1, column: column - 1))
        result.append(square(atRow: row - 1, column: column))
        result.append(square(atRow: row - 1, column: column + 1))

        result.append(square(atRow: row, column: column - 1))
        result.append(square(atRow: row, column: column + 1))

        result.append(square(atRow: row + 1, column: column - 1))
        result.append(square(atRow: row + 1, column: column))
        result.append(square(atRow: row + 1, column: column + 1))

        return result.compactMap { $0 }
    }

    func placeMines(avoiding: Square) {
        var possibleSquares = allSquares
        let disallowed = getAdjacentSquares(toRow: avoiding.row, column: avoiding.column) + CollectionOfOne(avoiding)
        possibleSquares.removeAll(where: disallowed.contains)

        for square in possibleSquares.shuffled().prefix(10) {
            square.hasMine = true
        }

        for row in rows {
            for square in row {
                let adjacentSquares = getAdjacentSquares(toRow: square.row, column: square.column)
                square.nearbyMines = adjacentSquares.filter(\.hasMine).count
            }
        }
    }
}

#Preview {
    ContentView()
}
