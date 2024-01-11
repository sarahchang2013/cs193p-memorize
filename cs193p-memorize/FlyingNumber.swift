//
//  FlyingNumber.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2024/1/11.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    var body: some View {
        if(number != 0) {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundColor(number<0 ? .gray : .blue)
                .shadow(color: .black, radius: 1.5, x:1, y:1)
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
