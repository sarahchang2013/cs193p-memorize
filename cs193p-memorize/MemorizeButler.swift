//
//  MemorizeGameButler.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/19.
//

import SwiftUI

class MemorizeButler : ObservableObject {
    typealias Card = MemorizeModel<String>.Card
    // 1.private global variable in MemorizeButler scope,outside is BAD
    // 2. cannot be a class property, initializer is random, gameModel may be initialized first
    private static let cardStorage = ["👀","🫁","🫀","🧠","👂🏻","🦶","🦿","🦷","👅","👃🏽","🥑","🥬"]
    
    @Published private var gameModel = MemorizeModel<String>(nPairsOfCards: 3){
        // 1.full code for cardContentFactory: (pairIndex: Int) -> String {return ...}
        // 2.type inference omits types, inline function format as foreach
        // 3.trailing closure syntax
        pairIndex in
        return cardStorage.indices.contains(pairIndex) ? cardStorage[pairIndex] : "⁉️"
    }
    
    var cards: Array<Card> {
        return gameModel.cards
    }
    
    var score: Int {
        gameModel.score
    }
    
    //MARK: - Intent
    
    func shuffle(){
        gameModel.shuffle()
    }
    
    func choose(_ card: Card){
        gameModel.choose(card: card)
    }
}
