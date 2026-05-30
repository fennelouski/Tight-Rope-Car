//
//  ContentView.swift
//  Tight Rope Car
//
//  Created by Nathan Fennel on 5/22/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        RootView()
            .hotWheelsSafeAreaPolicy()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [PlayerProfile.self, CourseHighScore.self], inMemory: true)
}
