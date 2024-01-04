//
//  CardView.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2024/1/4.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemorizeModel<String>.Card
    let card: Card
    
    //"_" means no need to add param label externally
    init(_ card: Card) {
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
    typealias Card = MemorizeModel<String>.Card
    return CardView(Card(id:"test", isFaceUp: true, content:"hi")).aspectRatio(3/2, contentMode: .fit).padding()
}
