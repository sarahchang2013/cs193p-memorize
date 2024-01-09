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
                    
            Button("Shuffle"){
                withAnimation{
                    butler.shuffle()
                }
            }
        }
        .padding()
    }
    
    var cards: some View {
        AspectVGrid(items: butler.cards, aspectRatio: Constants.cardAspRatio) {
            card in CardView(card)
                    .padding(Constants.inset)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: Constants.duration)) {
                            butler.choose(card)
                        }
                    }
        }
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
