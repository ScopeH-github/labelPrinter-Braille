import SwiftUI

struct MakeListView: View {
    var body: some View {
        NavigationView {
            VStack {
                List(dataTexts) { data in 
                    Button (action: {
                        MakeView(text: data.text)
                    }) {
                        Text(data.text)
                    }
                }.onAppear(perform: {
                    loadTextFromCSV()
                })
            }
            .navigationTitle("라벨 리스트")
        }
    }
}

struct MakeListView_Previews: PreviewProvider {
    static var previews: some View {
        MakeListView()
    }
}
