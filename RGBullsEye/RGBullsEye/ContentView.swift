//
//  ContentView.swift
//  RGBullsEye
//
//  Created by Ryan Hernandez on 2/12/20.
//  Copyright © 2020 Ryan Hernandez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let controller = ContentViewController()
    @State var rTarget = Double.random(in: 0..<1)
    @State var gTarget = Double.random(in: 0..<1)
    @State var bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var roundScore: Int
    @State var totalScore: Int
    @State var roundNumber: Int
    @State var message: String
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
                .padding(.leading, -4.0)
            }
            
            Button(action: {
                self.showAlert = true
                self.roundScore = self.controller.computeScore(
                    guesses: [self.rGuess, self.gGuess, self.bGuess],
                    targets: [self.rTarget, self.gTarget, self.bTarget])
                self.message = self.controller.getMessage(score: self.roundScore)
                
                self.totalScore += self.roundScore
                self.roundNumber += 1
            }) {
              Text("Hit Me!")
            }
            .foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess))
            .padding(.top, 20)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(message),
                    message: Text(String(self.roundScore)
                    ))
            }
            
            VStack {
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }
            
            VStack {
                Text("Score: \(self.totalScore)")
                Text("Round: \(self.roundNumber)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5, roundScore: 0, totalScore: 0, roundNumber: 0, message: "")
    }
}

struct ColorRectangle: View {
    var rVal: Double
    var gVal: Double
    var bVal: Double
    var body: some View {
        Rectangle()
            .padding(.trailing, -4.0)
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
