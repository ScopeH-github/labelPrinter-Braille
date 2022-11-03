import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MakeListView(datas: dataTexts)
                .onAppear {
                    loadTextFromCSV()
                }
                
        }
    }
}
