//
//  ContentView.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/18.
//

import SwiftUI

struct MemorizeView: View {
    @ObservedObject var butler: MemorizeButler
    typealias Card = MemorizeModel<String>.Card

    var body: some View {
        VStack {
            cards
                    
            HStack {
                Text("Score: \(butler.score)")
                    .animation(nil)
                Spacer()
                Button("Shuffle"){
                    withAnimation{
                        butler.shuffle()
                    }
                }
            }
            .font(.largeTitle)
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(items: butler.cards, aspectRatio: Constants.cardAspRatio) {
            card in CardView(card)
                    .padding(Constants.inset)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: Constants.duration)) {
                            let scoreBeforeChoose = butler.score
                            butler.choose(card)
                            let scoreChange = butler.score - scoreBeforeChoose
                            lastScoreChange = (scoreChange, card.id)
                        }
                    }
        }
    }
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    private struct Constants {
        static let cardAspRatio: CGFloat = 2/3
        static let inset: CGFloat = 5
        static let duration: CGFloat = 1
    }
}
    

    

#Preview {
    MemorizeView(butler: MemorizeButler())
}
