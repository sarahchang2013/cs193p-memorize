//
//  ContentView.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/18.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount :Int = 2
    let emojis:Array<String> = ["👀","🫁","🫀","🧠","👂🏻","🦶","🦿","👀","🫁","🫀","🧠","👂🏻","🦶","🦿"]

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
            ForEach(0..<emojis.count, id: \.self) {index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}
    
struct CardView: View {
    @State var isFaceUp = false
    let content: String
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.foregroundColor(.yellow)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill(.green).opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
    

#Preview {
    ContentView()
}
