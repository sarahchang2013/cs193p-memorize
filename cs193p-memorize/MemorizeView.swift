//
//  ContentView.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/18.
//

import SwiftUI

struct MemorizeView: View {
    @ObservedObject var butler: MemorizeButler

    var body: some View {
        VStack {
            cards
                .animation(.easeIn(duration: 0.2), value: butler.cards)
                    
            Button("Shuffle"){
                butler.shuffle()
                }
        }
        .padding()
    }
    
    var cards: some View {
        GeometryReader { geometry in
            let gridSize = bestGridWidth(
                count: butler.cards.count,
                size: geometry.size,
                asp_ratio: 2/3)
            LazyVGrid(columns:[GridItem(.adaptive(minimum: gridSize), spacing: 0)], spacing: 0) {
                ForEach(butler.cards) {card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(5)
                        .onTapGesture {
                            butler.choose(card)
                        }
                }
            }
        }
        .padding()
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
    
struct CardView: View {
    let card: MemorizeModel<String>.Card
    
    //"_" means no need to add param label externally
    init(_ card: MemorizeModel<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.foregroundColor(.yellow)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill(.green).opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}
    

#Preview {
    MemorizeView(butler: MemorizeButler())
}
