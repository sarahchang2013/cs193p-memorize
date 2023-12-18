//
//  ContentView.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/18.
//

import SwiftUI

struct ContentView: View {
    let emojis:Array<String> = ["👀","🫁","🫀","🧠"]
    var body: some View {
        HStack {
            ForEach(0..<4, id: \.self) {index in
                CardView(isFaceUp: true, content: emojis[index])
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
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.yellow)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}



#Preview {
    ContentView()
}
