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
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group{
                base.foregroundColor(.yellow)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .aspectRatio(Constants.contentAspRatio, contentMode: .fit)
                    .padding(Constants.inset)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill(.green).opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        static let contentAspRatio: CGFloat = 1
        struct FontSize {
            static let largest: CGFloat = 200
            static let scaleFactor: CGFloat = 0.01
        }
    }
}

#Preview {
    typealias Card = MemorizeModel<String>.Card
    return CardView(Card(id:"test", isFaceUp: true, content:"hi")).aspectRatio(3/2, contentMode: .fit).padding()
}
