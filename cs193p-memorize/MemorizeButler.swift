//
//  MemorizeGameButler.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/19.
//

import SwiftUI

class MemorizeButler {
    private var gameModel = MemorizeModel<String>(nPairsOfCards: 7, cardContentFactory: <#T##(Int) -> String#>)
    
    var cards: Array<MemorizeModel<String>.Card> {
        return gameModel.cards
    }
    
    func choose(_ card: MemorizeModel<String>.Card){
        gameModel.choose(card: <#T##MemorizeModel<String>.Card#>)
    }
}
