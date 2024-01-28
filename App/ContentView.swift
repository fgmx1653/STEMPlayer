//
//  ContentView.swift
//  App
//
//  Created by Srihari Yechangunja on 1/27/24.
//

import SwiftUI
import SwiftUIGIF
import WebKit
import ConfettiSwiftUI
import YouTubePlayerKit

var points = 0

struct ContentView: View {
    
    @State private var xPos = UIScreen.main.bounds.width / 2
    @State private var yPos = UIScreen.main.bounds.height / 2
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    let movement: CGFloat = 75
    
    @State var toggled = false
    
    @State var toggled2 = false
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .frame(width: 8000/6, height: 9600/6)
                .position(CGPoint(x: xPos, y: yPos))
                .onTapGesture { location in
                    withAnimation {
                        // top left corner
                        if location.x < width / 3 && location.y < height / 3{
                            xPos += movement
                            yPos += movement
                        }
                        // top right
                        else if location.x > 2 * width / 3 && location.y < height / 3{
                            xPos -= movement
                            yPos += movement
                        }
                        // top
                        else if width / 3 < location.x && location.x < 2 * width / 3 && location.y < height / 3  {
                            yPos += movement
                        }
                        // left
                        else if location.x < width / 2 && height / 3 < location.y && location.y < 2 * height / 3{
                            xPos += movement
                        }
                        // right
                        else if location.x > 2 * width / 3 && height / 3 < location.y && location.y < 2 * height / 3 {
                            xPos -= movement
                        }
                        // bottom left
                        else if location.x < width / 2 && location.y > 2 * height / 3 {
                            xPos += movement
                            yPos -= movement
                        }
                        // bottom
                        else if width / 3 < location.x && location.x < 2 * width / 3 && location.y > 2 * height / 3 {
                            yPos -= movement
                        }
                        // bottom right
                        else if location.x > 2 * width / 3 && location.y > 2 * height / 3 {
                            yPos -= movement
                            xPos -= movement
                        }
                        
                        
                        if 0 < xPos && xPos < 75 && 900 < yPos && yPos < 975 {
                            toggled.toggle()
                        }
                        
                        if 430 < xPos && xPos < 500 && 570 < yPos && yPos < 580 {
                            toggled2.toggle()
                        }
                    }
                }
            GifImage("gif")
                .frame(width: 45, height: 62)
            Text("x: \(xPos)\ny: \(yPos)")
                .offset(x: 100, y: 100)
        }
        .background(Color.blue)
        .navigate(to: DetailsView(toggled: $toggled), when: $toggled)
        .navigate(to: DetailsView2(toggled2: $toggled2), when: $toggled2)
    }
}

struct DetailsView2: View {
    
    @StateObject
        var youTubePlayer: YouTubePlayer = "https://youtube.com/watch?v=psL_5RIBqnY"
    
    @Binding var toggled2: Bool
    var body: some View {
        ScrollView() {
            HStack {
                Button() {
                    toggled2.toggle()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                        .imageScale(.large)
                }
                Spacer()
                Text("Videos")
                    .font(.largeTitle)
                    .bold()
                GifImage("gif")
                    .frame(width: 45, height: 62)
                Spacer()
            }
            .padding(.horizontal)
            YouTubePlayerView("https://youtube.com/watch?v=psL_5RIBqnY")
        }.background(Image("img").resizable().scaledToFill().edgesIgnoringSafeArea(.all))
    }
}

struct GifImage: UIViewRepresentable {
    private let name: String
    
//initialize a name
    init(_ name: String){
        self.name = name
    }
   
    func makeUIView(context: Context) -> some WKWebView {
        let webView = WKWebView()
        
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
       
        let data = try! Data(contentsOf: url)
       
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
 
        webView.scrollView.isScrollEnabled = false
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.reload()
    }
}

struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("delete")
    }
}

struct DetailsView: View {
    
    @Binding var toggled: Bool
    @State var screen = false
    
    var questions: [Question] = [
        Question(id: UUID(), choices: [0, 1, 0, 0], answers: ["Mechanical Engineer", "Civil Engineer", "Aerospace Engineer", "Computer Engineer"], question: "What kind of engineer designs buildings, bridges, and other structures?", answered: false),
        Question(id: UUID(), choices: [0, 1, 0, 0], answers: ["Astronomy", "Biology", "Physics", "Chemistry"], question: "Which field of science studies living organisms?", answered: false),
        Question(id: UUID(), choices: [0, 0, 1, 0], answers: ["Android", "Cyborg", "Domestic Robot", "Mechanic"], question: "What is a robot programmed to do tasks in our homes or offices called?", answered: false),
        Question(id: UUID(), choices: [0, 1, 0, 0], answers: ["Venus", "Mars", "Jupiter", "Earth"], question: "Which planet is known as the \"Red Planet\"?", answered: false),
        Question(id: UUID(), choices: [0, 1, 0, 0], answers: ["Code Wizard", "Web Developer", "Web Magician", "Internet Maker"], question: "What do you call a person who designs and builds websites?", answered: false),
        Question(id: UUID(), choices: [0, 0, 0, 1], answers: ["", "", "", ""], question: "Question 3", answered: false),
        Question(id: UUID(), choices: [1, 0, 0, 0], answers: ["", "", "", ""], question: "Question 1", answered: false),
        Question(id: UUID(), choices: [0, 1, 0, 0], answers: ["", "", "", ""], question: "Question 2", answered: false),
        Question(id: UUID(), choices: [0, 0, 0, 1], answers: ["", "", "", ""], question: "Question 3", answered: false),
        Question(id: UUID(), choices: [0, 1, 0, 0], answers: ["", "", "", ""], question: "Question 2", answered: false),
        Question(id: UUID(), choices: [0, 0, 0, 1], answers: ["", "", "", ""], question: "Question 3", answered: false),
        Question(id: UUID(), choices: [1, 0, 0, 0], answers: ["", "", "", ""], question: "Question 1", answered: false),
        Question(id: UUID(), choices: [0, 1, 0, 0], answers: ["", "", "", ""], question: "Question 2", answered: false),
        Question(id: UUID(), choices: [0, 0, 0, 1], answers: ["", "", "", ""], question: "Question 3", answered: false)
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView() {
            HStack {
                Button() {
                    toggled.toggle()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                        .imageScale(.large)
                }
                Spacer()
                Text("Levels")
                    .font(.largeTitle)
                    .bold()
                GifImage("gif")
                    .frame(width: 45, height: 62)
                Spacer()
            }
            .padding(.horizontal)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(0..<questions.count, id: \.self) { index in
                    NavigationLink() {
                        QuestionView(question: questions[index], screen: $screen)
                    } label: {
                        ZStack {
                            if questions[index].answered == true {
                                Rectangle()
                                    .foregroundColor(.gray)
                            }
                            Image("stone")
                                .resizable()
                                .frame(width: 175, height: 100)
                                .border(Color.white, width: 1)
                                .cornerRadius(15)
                            VStack {
                                Text("Level")
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.white)
                                Text("\(index+1)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .padding(.top)
                        }
                    }
                }
            }.padding(.horizontal)
        }.background(Image("img").resizable().scaledToFill().edgesIgnoringSafeArea(.all))
    }
}

struct Question: Identifiable {
    var id: UUID
    var choices: Array<Int>
    var answers: Array<String>
    var question: String
    @State var answered: Bool
}

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct QuestionView: View {
    
    var question: Question
    
    @State var reveal = false
    @State var showAlert = false
    
    @State private var counter = 0
    
    @Binding var screen: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text(question.question)
                .padding(.horizontal)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            VStack {
//                Text("Points: \(points)")
                HStack {
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 100)
                            .background(.ultraThinMaterial)
                            .border({
                                if !reveal {
                                    Color.white
                                } else {
                                    colors()[0]
                                    
                                }
                            }(), width: 2.5)
                            .cornerRadius(15)
                        Text(question.answers[0])
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width / 2 - 50, height: 100)
                            .multilineTextAlignment(.center)
                    }.onTapGesture {
                        if question.choices[0] == 0 {
                            showAlert = true
                        } else {
                            reveal.toggle()
                            points += 1
                            counter += 1
                            question.answered = true
                        }
                    }.alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Wrong answer"), message: Text("Try again!"))
                    })
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 100)
                            .background(.ultraThinMaterial)
                            .border({
                                if !reveal {
                                    Color.white
                                } else {
                                    colors()[1]
                                    
                                }
                            }(), width: 2.5)
                            .cornerRadius(15)
                        Text(question.answers[1])
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width / 2 - 50, height: 100)
                            .multilineTextAlignment(.center)
                    }
                    .onTapGesture {
                        if question.choices[1] == 0 {
                            showAlert = true
                        } else {
                            reveal.toggle()
                            points += 1
                            counter += 1
                            question.answered = true
                        }
                    }.alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Wrong answer"), message: Text("Try again!"))
                    })
                }
                HStack {
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 100)
                            .background(.ultraThinMaterial)
                            .border({
                                if !reveal {
                                    Color.white
                                } else {
                                    colors()[2]
                                    
                                }
                            }(), width: 2.5)
                            .cornerRadius(15)
                        Text(question.answers[2])
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width / 2 - 50, height: 100)
                            .multilineTextAlignment(.center)
                        
                    }
                    .onTapGesture {
                        if question.choices[2] == 0 {
                            showAlert = true
                        } else {
                            reveal.toggle()
                            points += 1
                            counter += 1
                            question.answered = true
                        }
                    }.alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Wrong answer"), message: Text("Try again!"))
                    })
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 100)
                            .background(.ultraThinMaterial)
                            .border({
                                if !reveal {
                                    Color.white
                                } else {
                                    colors()[3]
                                    
                                }
                            }(), width: 2.5)
                            .cornerRadius(15)
                        Text(question.answers[3])
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width / 2 - 50, height: 100)
                            .multilineTextAlignment(.center)
                    }
                    .onTapGesture {
                        if question.choices[3] == 0 {
                            showAlert = true
                        } else {
                            reveal.toggle()
                            points += 1
                            counter += 1
                            question.answered = true
                        }
                    }.alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Wrong answer"), message: Text("Try again!"))
                    })
                }
            }.confettiCannon(counter: $counter)
            Spacer()
            GifImage("gif")
                .frame(width: 45, height: 62)
        }.background(Image("wallpaper").resizable().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height).edgesIgnoringSafeArea(.all))
    }
    
    func colors() -> Array<Color> {
        
        var colorArray: Array<Color> = []
        let count = 0..<question.choices.count
        
        for i in count {
            if question.choices[i] == 1 {
                colorArray.append(Color.green)
            } else {
                colorArray.append(Color.red)
            }
        }
        return colorArray
    }
    
}

#Preview {
    ContentView()
}
