//
//  SingleSlider.swift
//  Magic Pacemaker
//
//  Created by Hannes Nagel on 8/17/24.
//

import SwiftUI

struct SingleSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let title : String?
    @State private var oldValue : Double
    @Namespace var namespace
    @State private var height = 0.0
    
    init(_ title: String = "", value: Binding<Double>, in range: ClosedRange<Double>){
        self._value = value
        self.range = range
        self.oldValue = value.wrappedValue
        self.title = title
    }
    
    var body: some View {
        GeometryReader{geo in
            let height = geo.size.height
            let lowerPartHeight = (value-range.lowerBound)/(range.upperBound-range.lowerBound)
            VStack(spacing: 0){
                Color.primary.colorInvert()
                    .overlay(alignment: .bottom){
                        if let title, height - (lowerPartHeight*height) > 20 {
                            Text(title).foregroundStyle(Color.accentColor)
                                .matchedGeometryEffect(id: "label", in: namespace)
                                .transition(.move(edge: .bottom).animation(.smooth))
                        }
                    }
                Color.primary
                    .frame(height: lowerPartHeight*height)
                    .overlay(alignment: .top){
                        if let title, height - (lowerPartHeight*height) <= 20 {
                            Text(title).foregroundStyle(Color.accentColor)
                                .matchedGeometryEffect(id: "label", in: namespace)
                                .transition(.move(edge: .bottom).animation(.smooth))
                                .padding(.top, 10)
                        }
                    }
            }
            .overlay{
                RoundedRectangle(cornerRadius: 30).stroke(Color.primary, lineWidth: 10)
            }
            .onChange(of: height, initial: true){
                self.height = height
            }
                .clipShape(.rect(cornerRadius: 30))
                .gesture(DragGesture()
                    .onChanged{ val in
                        let translation = -(val.translation.height)
                        value = value(for: translation)
                    }
                    .onEnded{ _ in
                        oldValue = value
                    }
                )
        }
    }
    func value(for dragHeight: Double) -> Double {
        let dragPortion = dragHeight / height
        let newValue = Double((range.upperBound - range.lowerBound) * dragPortion) + oldValue
        return min(max(newValue,range.lowerBound),range.upperBound)
    }
}
private struct Preview: View {
    @State private var value = 3.0
    var body: some View {
        SingleSlider(value: $value, in: 1...5)
    }
}
#Preview{Preview()}
