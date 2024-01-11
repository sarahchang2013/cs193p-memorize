//
//  MemorizeGame.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/19.
//

import Foundation

struct MemorizeModel<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
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
    
    var theOnlyFaceUpCardIndex: Int? {
        // read-write functions of a computed property
        get { cards.indices.filter{ index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = theOnlyFaceUpCardIndex {
                    // find a matched pair, score += 2
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    }
                    else {
                        // the pair isn't a match, penalize on revealed cards
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                    print("hasBeenSeen: \(cards[chosenIndex].hasBeenSeen), \(cards[potentialMatchIndex].hasBeenSeen)")
                    print("Score: \(score)")
                }
                else {
                    theOnlyFaceUpCardIndex = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var id: String
        var isFaceUp = false {
            didSet {
                // "seen" when flipped back down
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var isMatched = false
        var content: CardContent
        var hasBeenSeen = false
        
        var debugDescription: String{
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}

extension Array {
    var only : Element? {
        count == 1 ? first : nil
    }
}
