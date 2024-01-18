//
//  AspectVGrid.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/29.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            let gridSize = bestGridWidth(
                count: items.count,
                size: geometry.size,
                asp_ratio: aspectRatio)
            LazyVGrid(columns:[GridItem(.adaptive(minimum: gridSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode:.fit)
                }
            }
        }
    }
    
    func bestGridWidth (
        count: Int,
        size: CGSize,
        asp_ratio: CGFloat
    ) -> CGFloat {
        let fcount = CGFloat(count)
        var columnCount = 1.0
        //print("screen width:\(size.width) screen height:\(size.height)")
        repeat {
            let width = size.width / columnCount
            let height = width / asp_ratio
            let rowCount = (fcount / columnCount).rounded(.up)
            //print("height:\(height) row count:\(rowCount)")
            if height * rowCount < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while (columnCount < fcount)
        return size.width/fcount
    }
}
