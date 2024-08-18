//
//  ContentView.swift
//  Magic Pacemaker
//
//  Created by Hannes Nagel on 8/17/24.
//

import SwiftUI


struct ContentView: View {
    @State private var manageSubs = false
    @AppStorage("showOnBoarding") private var showOnBoarding = true

    var body: some View {
        if showOnBoarding{
            OnBoardingView()
        } else {
            VStack {
                SoundSlider()
                    .padding(.horizontal)
                Button("Some information about the app"){manageSubs = true}
            }
            .sheet(isPresented: $manageSubs) {
                PaywallView()
            }
        }
    }
}


#Preview {
    ContentView()
}
