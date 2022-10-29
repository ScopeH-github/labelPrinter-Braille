/// App Layout

import SwiftUI
import KorToBraille                    // Using External Package

struct MakeView: View {
    @State public var text = ""
    @State private var korBraille = ""
    @State private var brailleCount = 0
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        HStack {
                            TextBox(text: $text, korBraille: $korBraille)
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    } header: {
                        Text("라벨 텍스트")
                    } footer: {
                        Text("한글과 숫자로만 적어주세요")
                            .font(.callout)
                    }
                    .headerProminence(.increased)
                    Section {
                        Text(korBraille)
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .onChange(of: korBraille) { braille in
                                var text = braille
                                if text != "" {
                                    text.removeLast()
                                }
                                brailleCount = text.count
                            }
                    } header: {
                        Text("점역 결과")
                    } footer: {
                        HStack{
                            Spacer()
                            Text("\(brailleCount) / 40")
                                .multilineTextAlignment(.leading)
                                .font(.callout)
                                .lineLimit(nil)
                        }
                    }
                    .headerProminence(.increased)
                }
                .padding(.vertical, 30)
                
                Spacer()
                
                VStack {
                    HStack {
                        Button(action: {
                            saveData(text: text)
                        }) {
                            Text("저장")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .font(.title2)
                        }
                        .buttonStyle(.bordered)
                        .padding(5)
                        .padding(.leading)
                        .padding(.bottom)
                        
                        Button(action: {
                            printData(korBraille, text: text)
                        }) {
                            Text("인쇄")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(5)
                        .padding(.trailing)
                        .padding(.bottom)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("라벨 만들기")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: {
            korBraille = transKorBraille(text)
        })
        .navigationViewStyle(.stack)
    }
    
    func saveData(text: String) {
        dataTexts.append(DataStruct(text: text))
        createCSV()
    }
    
    /// for DEBUG
    func printData(_ braille: String, text: String) {
        var brailleData = [Int]()
        for char in braille {
            brailleData.append(brailleToInt(char))
        }
        
        if text != "" {
            print("\(text): ", terminator: "")
            for i in brailleData {
                print(i, terminator: " ")
            }     
            print()
        }
    }
}


// SwiftUI doesn't clearable Textfield
struct TextBox: View {
    @Binding var text: String
    @Binding var korBraille: String
    var body: some View {
        ZStack{
            TextEditor(text: $text)
                .onChange(of: text) { 
                    korText in 
                    korBraille = transKorBraille(korText)
                }
            Text(text)
                .opacity(0)
                .padding(.vertical)
                .frame(minHeight: 100)
        }
        .multilineTextAlignment(.center)
        .font(.title)
    }
}

struct MakeView_Previews: PreviewProvider {
    static var previews: some View {
        MakeView()
    }
}
