//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Macmaurice Osuji on 2/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    
    //Animation var
    @State private var animationAmount = 0.0
    @State private var blurAmount = 0.0
    @State private var scaleAmount = 1.0

    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.1, blue: 0.45),location: 0.3),
                .init(color: Color(red: 0.56, green: 0.15, blue: 0.45),location: 0.3)
            ], center: .top, startRadius: 100, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing:40) {
                    VStack {
                        Text("Which is the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {
                        number in Button( action: {flagTapped(number)
                    
                        }){ Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(color: .black, radius: 5)
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .rotation3DEffect(.degrees(number == correctAnswer ? animationAmount: 0), axis: (x: 0, y: 1, z: 0))
                                .blur(radius: number != correctAnswer ? blurAmount: 0)
                                .scaleEffect(number != correctAnswer ? scaleAmount: 1)

                        }
                    }

                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                Spacer()
                Spacer()
                
                Text("Current Score is \(score)")
                    .font(.title2.weight(.semibold))
                Spacer()
            }
            .padding()
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
        }
    }
    func flagTapped (_ num: Int) {
        if num == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            withAnimation {
                animationAmount += 360 * 5
                blurAmount += 10
                scaleAmount -= 0.2
            }
        } else {
            scoreTitle = "Wrong!"
            if score > 0 {
                scoreTitle = "Wrong, you've lost a score."
                score -= 1
            }
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        blurAmount = 0.0
        scaleAmount = 1.0
    }
     
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
