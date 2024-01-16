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
        // update the view at a sequence of time points (schedule)
        TimelineView(.animation(minimumInterval: 1/5)) {_ in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngel:.degrees(card.bonusPercentRemaining * 360))
                    .fill(.white)
                    .opacity(Constants.counterOpacity).padding(Constants.inset)
                    .overlay(
                        cardContents.padding(Constants.inset))
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
            } else {
                // if card.isMatched && !card.isFaceUp
                // stops rotation when it's matched and disappearing
                Color.clear
            }
        }
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(Constants.contentAspRatio, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: Constants.duration), value: card.isMatched)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        static let contentAspRatio: CGFloat = 1
        static let counterOpacity: CGFloat = 0.7
        static let duration: CGFloat = 0.7
        struct FontSize {
            static let largest: CGFloat = 200
            static let scaleFactor: CGFloat = 0.01
        }
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
        
    }
}

#Preview {
    typealias Card = MemorizeModel<String>.Card
    return CardView(Card(id:"test", isFaceUp: true, content:"hi")).aspectRatio(1, contentMode: .fit).padding()
}
