//
//  SettingsView.swift
//  Edutainment
//
//  Created by Kat Ou on 02.06.2020.
//  Copyright © 2020 Kat Ou. All rights reserved.
//

import SwiftUI

struct QuestionAnswer:Hashable {
    let question: String
    let answer: Int
}

struct SettingsView: View {
    private let tableOfMultiplication = ["🐳", "🦄", "🐝","🦜", "🦁", "🐷", "🐣", "🦋", "🦚", "🐲", "🦌", "🦍", "🐠", "🦐", "🦖", "🐞"].shuffled()
    let questions = [5, 10, 30, 60, 110]
    @State var numberOfQuestions = 1

    var readyQuestions: [QuestionAnswer] {
        var questionsInner:Array<Int> = []
        for theme in selectKeeper.sorted(){
            questionsInner.append(tableOfMultiplication.firstIndex(of: theme)! + 1)
        }
        var readyAllQuestions:Array<QuestionAnswer> = []
        for itemOuter in questionsInner{
            for itemInner in (1...10){
                readyAllQuestions.append((QuestionAnswer(question: "\(itemOuter) X \(itemInner)", answer: itemOuter*itemInner)))
            }
        }
        if readyAllQuestions.count > questions[numberOfQuestions]{
            readyAllQuestions.shuffle()
            readyAllQuestions.removeSubrange((questions[numberOfQuestions])...(readyAllQuestions.count-1))
            return readyAllQuestions
        }else{
            return readyAllQuestions.shuffled()
            }
        }
    
    
    @State var selectKeeper = Set<String>()
    @State var isEditMode: EditMode = .active
    
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1))]
    }
    
    @State private var animationAmount = 1.0

    
    var body: some View {
        NavigationView{
            VStack{
                Group{
                    Section{
                        List(tableOfMultiplication[1..<12], id: \.self, selection: $selectKeeper){
                            
                            Text("Multiplication \((self.tableOfMultiplication.firstIndex(of: $0)!)+1) X \($0)")
                                .foregroundColor(Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 0.700583262)))
                        }
                    }
                    
                    Section(header: Text("Number of questions").foregroundColor(Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)))){
                        Picker("", selection: $numberOfQuestions){
                            ForEach(0..<questions.count){
                                Text("\(self.questions[$0])")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                    }
                    Section{
                        NavigationLink(destination: GameView(questions: readyQuestions)){
                            Text("S T A R T")
                                .bold()
                                .buttonStyle(PlainButtonStyle())
                                .frame(maxWidth: 300)
                                .padding()
                                .foregroundColor(Color(#colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)))
                                .background(Color(#colorLiteral(red: 0, green: 0.9195801616, blue: 0.9863323569, alpha: 1)))
                                .cornerRadius(15)
                        }.isHidden(real: (readyQuestions.count > 0 ? false : true))
                    }
                }
            }
            .navigationBarTitle(Text("Choose the level"))
            .environment(\.editMode, self.$isEditMode)
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

// MARK: Building custom modifire using ViewModifier_2
struct IsHidden: ViewModifier {
    var real: Bool
    func body(content: Content) -> some View {
        (real ? nil : content.animation(.easeInOut(duration: 2)))
            .rotation3DEffect(.degrees(1), axis: (x: 0, y: 1, z: 0))
    }
}

extension View {
    func isHidden(real: Bool) -> some View {
        self.modifier(IsHidden(real: real))
    }
}
