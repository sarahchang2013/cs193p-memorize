//
//  MemorizeGame.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/19.
//

import Foundation

struct MemorizeModel<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    init(nPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        for pairIndex in 0..<max(2,nPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id:"\(pairIndex+1)1a", content: content))
            cards.append(Card(id:"\(pairIndex+1)1b", content: content))
        }
        
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    mutating func choose(card: Card){
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for ind in cards.indices {
            if cards[ind].id == card.id{
                return ind
            }
        }
        return 0 // FIXME: temporary
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var id: String
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        
        
        var debugDescription: String{
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
        
       
        
        
        

    }
}
