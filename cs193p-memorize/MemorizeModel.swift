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
                        score += 2 + cards[chosenIndex].bonus + cards[potentialMatchIndex].bonus
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
                    //print("hasBeenSeen: \(cards[chosenIndex].hasBeenSeen), \(cards[potentialMatchIndex].hasBeenSeen)")
                    //print("Score: \(score)")
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
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                // "seen" when flipped back down
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var hasBeenSeen = false
        
        var debugDescription: String{
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
        // MARK: - Bonus Time
        
        // call this when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            // use comma instead of && in if to unwrap optionals
            if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastDateTurnedFaceUp == nil {
                lastDateTurnedFaceUp = Date()
            }
        }
        
        // call this when the card goes back face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastDateTurnedFaceUp = nil
        }
        
        // the bonus earned so far (one point for every second of the bonusTimeLimit that was not used)
        // this gets smaller and smaller the longer the card remains face up without being matched
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        // percentage of the bonus time remaining
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        // how long this card has ever been face up and unmatched during its lifetime
        // basically, pastFaceUpTime + time since lastDateTurnedFaceUp
        var faceUpTime: TimeInterval {
            if let lastDateTurnedFaceUp {
                //print("\(id) : lastDateTurnedFaceUp: \(lastDateTurnedFaceUp)")
                return pastFaceUpTime + Date().timeIntervalSince(lastDateTurnedFaceUp)
            } else {
                //print("\(id) : lastDateTurnedFaceUp: nil")
                return pastFaceUpTime
            }
        }
        
        // can be zero which would mean "no bonus available" for matching this card quickly
        var bonusTimeLimit: TimeInterval = 6
        
        // the last time this card was turned face up
        var lastDateTurnedFaceUp: Date?
        
        // the accumulated time this card was face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0 
    }
}

extension Array {
    var only : Element? {
        count == 1 ? first : nil
    }
}
