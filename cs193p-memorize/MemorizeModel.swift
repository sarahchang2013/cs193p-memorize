//
//  MemorizeGame.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/19.
//

import Foundation

struct MemorizeModel<CardContent> {
    private(set) var cards: Array<Card>
    
    init(nPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        for pairIndex in 0..<nPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
    }
    
    func choose(card: Card){
        
    }
    
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
}
