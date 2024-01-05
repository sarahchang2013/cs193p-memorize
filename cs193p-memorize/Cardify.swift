//
//  Cardify.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2024/1/5.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool

    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.fill(.yellow)
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill(.green)
                .opacity(isFaceUp ? 0 : 1)
        }
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
