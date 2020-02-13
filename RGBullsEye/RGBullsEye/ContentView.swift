//
//  ContentView.swift
//  RGBullsEye
//
//  Created by Ryan Hernandez on 2/12/20.
//  Copyright © 2020 Ryan Hernandez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false
    
    var body: some View {
        VStack {
            HStack {
                // Target color block
                VStack {
                    ColorRectangle(rVal: rTarget, gVal: gTarget, bVal: bTarget)
                    Text("Match this color")
                }
                
                // Guess Color Block
                VStack {
                    ColorRectangle(rVal: rGuess, gVal: gGuess, bVal: bGuess)
                    HStack {
                        HStack {
                          Text("R: \(Int(rGuess * 255.0))")
                          Text("G: \(Int(gGuess * 255.0))")
                          Text("B: \(Int(bGuess * 255.0))")
                        }
                    }
                }
            }
            
            Button(action: {
                self.showAlert = true
            }) {
              Text("Hit Me!")
            }
            .foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your Score"), message: Text("\(computeScore())"))
            }
            
            VStack {
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }
        }
    }
    

    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        return Int((1.0 - diff) * 100.0 + 0.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
    }
}

struct ColorRectangle: View {
    var rVal: Double
    var gVal: Double
    var bVal: Double
    var body: some View {
        Rectangle()
            .foregroundColor(Color(red: rVal, green: gVal, blue: bVal, opacity: 1))
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        HStack {
            Text("0")
                .foregroundColor(textColor)
            Slider(value: $value)
            Text("255")
                .foregroundColor(.red)
        }
        .padding()
    }
}
