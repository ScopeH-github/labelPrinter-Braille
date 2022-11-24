import SwiftUI

public func exportBRT(from brtData: String) {

    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

    let fileURL = documentsURL.appendingPathComponent("\(Date()).brt")

    let textString = NSString(string: brtData)
    
    try? textString.write(to: fileURL, atomically: true, encoding: String.Encoding.ascii.rawValue)
}


public struct DataStruct: Identifiable, Hashable {
    public var id = UUID()
    public var text: String
}

public var dataTexts: [DataStruct] = []

public func loadTextFromCSV() -> [DataStruct] {
    if let path = Bundle.main.path(forResource: "dataFile", ofType: "csv") {
        parseCSV(at: URL(fileURLWithPath: path), datas: &dataTexts)
    }
    return dataTexts
}

private func parseCSV(at filePath: URL, datas: inout [DataStruct]) {
    do {
        let data = try Data(contentsOf: filePath)
        let dataEncoded = String(data: data, encoding: .utf8)
        
        if let dataArray = dataEncoded?.components(separatedBy: ",") {
            for item in dataArray {
                let structedItem = DataStruct(text: item)
                datas.append(structedItem)
            }
        }
    } catch {
        print("Failed Loading CSV File")
    }
}

public func createCSV() {
    var commaText = ""
    
    for data in dataTexts {
        commaText += (data.text + ",")
    }
    if !commaText.isEmpty {
        commaText.removeLast()
    }
    
    let fManager = FileManager.default
    
    let folderName = "data"
    let csvFileName = "dataFile.csv"
    
    
    let documentURL = fManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let directoryURL = documentURL.appendingPathComponent(folderName)
    
    do {
        try fManager.createDirectory(atPath: directoryURL.path, withIntermediateDirectories: true, attributes: nil)
    } catch let error as Error {
        print("Folder Creation Failed: \(error)")
    }
    
    
    let fileURL = directoryURL.appendingPathComponent(csvFileName)
    let fileData = commaText.data(using: .utf8)
    
    do {
        try fileData?.write(to: fileURL)
        print("Writing CSV to \(fileURL.path)")
    } catch let error as Error {
        print("CSV File Creation Failed: \(error)")
    }
}
