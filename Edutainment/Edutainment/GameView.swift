//
//  GameView.swift
//  Edutainment
//
//  Created by Kat Ou on 03.06.2020.
//  Copyright © 2020 Kat Ou. All rights reserved.
//

import SwiftUI

struct GameView: View {
    
    @State var questions: Array<QuestionAnswer> = []
    
     var answers:Array<Int>
        {
            var answers = [questions[0].answer]
            while answers.count < 4 {
                let tempAnswer = Int.random(in: (questions[0].answer-10)...(questions[0].answer+10))
                if  ((tempAnswer > 0) && !answers.contains(tempAnswer) && (questions[0].answer % 2 == tempAnswer % 2)) {
                    answers.append(tempAnswer)
                }
            }
                return answers.shuffled()
        }
    
    var body: some View {
            Group{
                QuestionView(questions: $questions, question: questions[0].question, rightAnswer: questions[0].answer, answers: answers)
            }
            .navigationBarTitle(Text("Let's get fun"))
        }
    }

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct QuestionView: View {
    
    @Binding var questions : Array<QuestionAnswer>
    var question: String = ""
    var rightAnswer:Int = 0
    var answers:Array<Int> = []
//    {
////        generateAnswers()
//        var answers = [rightAnswer]
//        while answers.count < 4 {
//            let tempAnswer = Int.random(in: (rightAnswer-10)...(rightAnswer+10))
//            if  ((tempAnswer > 0) && !answers.contains(tempAnswer) && (rightAnswer % 2 == tempAnswer % 2)) {
//                answers.append(tempAnswer)
//            }
//        }
//        print(question, answers)
//            return answers.shuffled()
//    }
    
    @State private var score = 0
    @State private var message: String = ""
    
    var body: some View{
        Section{
            Spacer()
            Text(message)
            Text("\(question) = ???")
                .foregroundColor(Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)))
                .font(.largeTitle)
            VStack{
                ForEach(1..<3){ row in
                    HStack{
                        ForEach(1..<3){ column in
                            Button ("\(self.answers[row==1 ? column-1 : (row+column-1)])")
                            {
                                self.checkAnswer(row: row, column: column)
                            }
                            .frame(maxWidth: 100)
                            .padding()
                            .foregroundColor(Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)))
                            .background(Color(#colorLiteral(red: 0, green: 0.9195801616, blue: 0.9863323569, alpha: 1)))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 0.700583262)), lineWidth: 3)
                            )
                        }
                    }
                }
            }
            Spacer()
            Text("Score: \(score)")
            .foregroundColor(Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)))
        }
    }
    func checkAnswer(row: Int, column: Int) {
        var tempAnswer: Int = 0
        if row==1{
            tempAnswer = answers[column-1]
        }
        else{
            tempAnswer = answers[row+column-1]
        }
        if tempAnswer != rightAnswer {
            message = ("\(tempAnswer) is wrong \(rightAnswer) was right")
        } else {
            score += 10
        }
        if questions.count > 1{
            questions.remove(at: 0)
        }else {
            message = "it was the last question"}
    }
}
