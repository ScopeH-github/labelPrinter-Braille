/// App Layout

import SwiftUI
import KorToBraille                    // Using External Package

struct MakeView: View {
    @State private var alertComponent: (String, String) = ("", "")
    @State private var showingAlert = false
    @State public var text = ""
    @State private var korBraille = ""
    @State private var brailleCount = 0
    var body: some View {
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
                        .accessibilityLabel("모두 지우기")
                        .accessibilityHint("텍스트를 모두 지우려면 이중 탭하십시오.")
                
                    }
                } header: {
                    Text("텍스트")
                } footer: {
                    Text("한글과 숫자로만 적어주세요")
                        .font(.callout)
                }
                .headerProminence(.increased)
                Section {
                    Text(korBraille)
                        .multilineTextAlignment(.leading)
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
                    .alert(alertComponent.0, isPresented: $showingAlert) {
                        Button("OK") {}
                    } message: {
                        Text(alertComponent.1)
                    }
                    .buttonStyle(.bordered)
                    .padding(5)
                    .padding(.leading)
                    .padding(.bottom)
                    
                    Button(action: {
                        printData(korBraille, text: text)
                    }) {
                        Text("내보내기")
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
            .scrollContentBackground(.hidden)
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onTapGesture {
            self.hideKeyboard()
        }
        .onAppear(perform: {
            korBraille = transKorBraille(text)
        })
    }
    
    func saveData(text: String) {
        if !text.isEmpty {
            dataTexts.append(DataStruct(text: text))
            createCSV()
            showingAlert = true
            alertComponent = ("저장 완료", "저장이 완료되었습니다.")
        }
    }
    
    
    func printData(_ braille: String, text: String) {
        var brailleData = String()
        for char in braille {
            brailleData.append(brailleToBRF(char))
        }
        
        if text != "" {
            /*
            print("\n")
            print("\(text): ", terminator: "")
            */ // for DEBUG
            
            let fileName = exportBRF(from: brailleData)
            showingAlert = true
            alertComponent = ("변환 완료", "\(fileName)\n파일 앱을 열어 저장된 파일을 확인할 수 있습니다.")
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
        .multilineTextAlignment(.leading)
        .font(.title)
    }
}

struct MakeView_Previews: PreviewProvider {
    static var previews: some View {
        MakeView()
    }
}
