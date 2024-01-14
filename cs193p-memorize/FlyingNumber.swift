//
//  FlyingNumber.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2024/1/11.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    @State private var offset: CGFloat = 0
    var body: some View {
        if(number != 0) {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundColor(number<0 ? Color.black : Color.pink)
                .shadow(color: .black, radius: 1.5, x:1, y:1)
                .offset(x:0, y: offset)
                .opacity(offset==0 ? 1 : 0)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.5)) {
                        offset = number>0 ? -300 : 300
                    }
                }
                .onDisappear(){
                    offset = 0
                }
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
