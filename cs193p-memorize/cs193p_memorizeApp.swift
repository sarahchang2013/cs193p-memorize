//
//  cs193p_memorizeApp.swift
//  cs193p-memorize
//
//  Created by sarahchangzsy on 2023/12/18.
//

import SwiftUI

@main
struct cs193p_memorizeApp: App {
    @StateObject var memorize = MemorizeButler()

    var body: some Scene {
        WindowGroup {
            MemorizeView(butler: memorize)
        }
    }
}
