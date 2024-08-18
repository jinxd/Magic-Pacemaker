//
//  PaywallView.swift
//  Magic Pacemaker
//
//  Created by Hannes Nagel on 8/17/24.
//

import SwiftUI
import StoreKit


struct PaywallView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
            NavigationStack {
                List{
                    Section{
                        Text("A Little Warning")
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundStyle(.red)
                            .listRowBackground(Color.clear)
                    }
                    Text("You can't subscribe right now.")
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
                        Text("AGAIN: If I notice that this app is used I might add these features.").foregroundStyle(.red).bold()
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
    }
}

#Preview {
    PaywallView()
}
