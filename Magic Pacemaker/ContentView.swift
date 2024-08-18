//
//  ContentView.swift
//  Magic Pacemaker
//
//  Created by Hannes Nagel on 8/17/24.
//

import SwiftUI


struct ContentView: View {
    @State private var manageSubs = false
    @AppStorage("subscribed") private var subscribed = false
    @AppStorage("showOnBoarding") private var showOnBoarding = true

    var body: some View {
        if showOnBoarding{
            OnBoardingView()
        } else {
            VStack {
                SoundSlider()
                    .padding(.horizontal)
                Button(subscribed ? "Manage Subscription" : "Support Me and get access soon to some great features"){manageSubs = true}
                    .subscriptionStatusTask(for: "") { state in
                        let isSubscribed = state.value?.reduce(false, { partialResult, newValue in
                            partialResult || newValue.state == .subscribed
                        }) ?? false
                        subscribed = isSubscribed
                    }
            }
            .sheet(isPresented: $manageSubs) {
                PaywallView(isSubscribed: subscribed)
            }
        }
    }
}


#Preview {
    ContentView()
}
