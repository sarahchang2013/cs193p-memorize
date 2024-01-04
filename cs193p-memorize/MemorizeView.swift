//
//  ContentView.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/18.
//

import SwiftUI

struct MemorizeView: View {
    @ObservedObject var butler: MemorizeButler
    
    private let aspectRatio :CGFloat = 2/3

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
        AspectVGrid(items: butler.cards, aspectRatio: aspectRatio) {
            card in CardView(card)
                    .aspectRatio(aspectRatio,contentMode:.fit)
                    .padding(5)
                    .onTapGesture {
                        butler.choose(card)
                    }
        }
    }
}
    

    

#Preview {
    MemorizeView(butler: MemorizeButler())
}
