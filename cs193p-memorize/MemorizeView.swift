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
            ScrollView {
                cards
                    .animation(.easeIn(duration: 0.2), value: butler.cards)
            }
            Button("Shuffle"){
                butler.shuffle()
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns:[GridItem(.adaptive(minimum: 100))]) {
            ForEach(butler.cards) {card in
                VStack {
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                    .padding(5)
                    Text(card.id)
                }
                
            }
        }
        .foregroundColor(.orange)
        .padding()
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
    }
}
    

#Preview {
    MemorizeView(butler: MemorizeButler())
}
