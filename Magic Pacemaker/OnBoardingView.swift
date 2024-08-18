//
//  OnBoardingView.swift
//  Magic Pacemaker
//
//  Created by Hannes Nagel on 8/18/24.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("showOnBoarding") private var showOnBoarding = true

    var body: some View {
        OnBoardingBuilder(views: [
            "Welcome to Pacemaker",
            "Keep your Pace",
            "While Running or Biking",
            "A steady rhythm",
            "in the background",
            "while being able to listen to",
            "any other Podcast or Music",
            "in any other App",
        ]) {
            showOnBoarding = false
        }
    }
}

#Preview {
    OnBoardingView()
}


struct OnBoardingBuilder: View {
    @State private var views: [(offset: Int, element: String)]
    @State private var selected = 0
    @State private var wasntSure = 0
    @State private var runningTask : Task<Void, Never>?
    let dismiss: () -> Void

    init(views: [String], dismiss: @escaping () -> Void) {
        _views = State(initialValue: views.enumerated().map { $0 })
        self.dismiss = dismiss
    }

    var body: some View {
        VStack {
            if selected < views.count {
                Text(views[selected].element)
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .onAppear {
                        runningTask?.cancel()
                        runningTask = Task {
                            try? await Task.sleep(for: .seconds(views[selected].element.count / 10))
                            next()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .transition(.slide)
                    .id(selected)
            } else {
                VStack {
                    Text("Did you get that?")
                        .font(.title.bold())
                        .padding()

                    Button("Yes, totally!") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .font(.title.bold())

                    Button("I am not quite sure") {
                        wasntSure += 1
                        next()
                    }
                    .padding(.bottom, 30)

                    if wasntSure > 0 {
                        Text("You might want to contact me")
                        Link("info@hannesnagel.com", destination: URL(string: "mailto:info@hannesnagel.com")!)
                    }
                }
                .transition(.slide)
            }
        }
        .padding()
    }

    private func next() {
        withAnimation {
            selected = (selected + 1) % (views.count + 1)
        }
    }
}
