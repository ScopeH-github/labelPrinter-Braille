import SwiftUI

struct MakeListView: View {
    @State public var datas: [DataStruct] = []
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(datas, id: \.self) { data in
                        NavigationLink(
                            data.text, destination: MakeView(text: data.text)
                                .navigationBarTitle("문구 만들기")
                        )
                    }
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                
                }
                .onAppear(perform: {
                    datas.removeAll()
                    datas = loadTextFromCSV()
                })
            }
            .navigationTitle("저장된 문구")
            .navigationBarItems(trailing: EditButton())
            .toolbar {
                NavigationLink(
                    destination: MakeView()
                        .navigationBarTitle("문구 만들기")
                ) {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
    }
    
    func deleteItem(at offset: IndexSet) {
        datas.remove(atOffsets: offset)
        dataTexts.remove(atOffsets: offset)
        createCSV()
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        datas.move(fromOffsets: source, toOffset: destination)
        dataTexts.move(fromOffsets: source, toOffset: destination)
        createCSV()
    }
}

struct MakeListView_Previews: PreviewProvider {
    static var previews: some View {
        MakeListView()
    }
}
