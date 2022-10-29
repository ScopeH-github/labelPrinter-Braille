import SwiftUI

struct MakeListView: View {
    @State private var datas = dataTexts
    var body: some View {
        NavigationView {
            VStack {
                List(datas) { data in 
                    NavigationLink(data.text, destination: MakeView(text: data.text))
                }
                .onAppear(perform: {
                    loadTextFromCSV()
                    datas = dataTexts
                })
            }
            .navigationTitle("라벨 리스트")
            .toolbar {
                NavigationLink(destination: MakeView()) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
    }
}

struct MakeListView_Previews: PreviewProvider {
    static var previews: some View {
        MakeListView()
    }
}
