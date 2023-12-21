//
//  ContentView.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/18.
//

import SwiftUI

struct MemorizeView: View {
    var butler: MemorizeButler = MemorizeButler()

    var body: some View {
        VStack {
            ScrollView {
                cards
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns:[GridItem(),GridItem(),GridItem()]) {
            ForEach(0..<butler.cards.count, id: \.self) {index in
                CardView(card: butler.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}
    
struct CardView: View {
    var card: MemorizeModel<String>.Card
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.foregroundColor(.yellow)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.largeTitle)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill(.green).opacity(card.isFaceUp ? 0 : 1)
        }
    }
}
    

#Preview {
    MemorizeView()
}
