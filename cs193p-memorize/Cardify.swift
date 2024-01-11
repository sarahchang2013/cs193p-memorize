//
//  Cardify.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2024/1/5.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable{
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    var rotation: Double
    var animatableData: Double {
        get{ rotation }
        set{ rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.fill(.yellow)
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill(Color.mint)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            .degrees(rotation),
            axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
        )
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        static let contentAspRatio: CGFloat = 1
        static let counterOpacity: CGFloat = 0.7
        struct FontSize {
            static let largest: CGFloat = 200
            static let scaleFactor: CGFloat = 0.01
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
