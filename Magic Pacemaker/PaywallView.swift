//
//  PaywallView.swift
//  Magic Pacemaker
//
//  Created by Hannes Nagel on 8/17/24.
//

import SwiftUI
import StoreKit


struct PaywallView: View {
    let isSubscribed: Bool
    @State private var showWarning = true
    @Environment(\.dismiss) var dismiss

    var body: some View {
        if showWarning && !isSubscribed {
            NavigationStack {
                List{
                    Section{
                        Text("A Little Warning")
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundStyle(.red)
                            .listRowBackground(Color.clear)
                    }
                    Text("There is NO direct benefit for you by subscribing.")
                    Text("The only thing this changes are my priorities. If people actually subscribe, they show me that they like this App.")
                    Text("Because I am a single Person with limited time and too many ideas, I might **NEVER** implement features here like:")
                    Section("Automatic Frequency Adjustment:"){
                        Text("Adjusts the frequency of sounds automatically based on your speed and step length or RPM. Set a target speed and Magic Pacemaker will slowly adjust the frequency until you reach your target speed")
                    }
                    Section("Intervals:"){
                        Text("Create your own Intervals and get up to speed.")
                    }
                    Section("Reminders:"){
                        Text("Get a Reminder when you start moving and it seems as if you start running or cycling")
                    }
                    Section("Other"){
                        Text("Widgets, Control Center and Lock Screen integration, ...")
                    }
                    Section{
                        Text("AGAIN: Subscribing only changes the likelyhood of me implementing such features").foregroundStyle(.red).bold()
                    }
                    Section{
                        Button("Okay, got it"){showWarning = false}
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button{
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.circle)
                    }
                }
            }
        } else if isSubscribed {
            SubscriptionStoreView(groupID: "magicians")
                .subscriptionStoreControlStyle(.automatic)
        } else {
            NavigationStack{
                Text("You are subscribed")
                    .manageSubscriptionsSheet(isPresented: .constant(true), subscriptionGroupID: "magicians")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button{
                                dismiss()
                            } label: {
                                Image(systemName: "xmark")
                            }
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.circle)
                        }
                    }

            }
        }
    }
}

#Preview {
    PaywallView(isSubscribed: false)
}

#Preview {
    PaywallView(isSubscribed: true)
}
