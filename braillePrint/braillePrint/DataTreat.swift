import SwiftUI

public struct DataStruct: Identifiable, Hashable {
    public var id = UUID()
    public var text: String
}

public var dataTexts: [DataStruct] = []

let fManager = FileManager.default
let docPath = fManager.urls(for: .documentDirectory, in: .userDomainMask)[0]


public func exportBRT(from brtData: String) -> String {
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMdd_HHmmss"    // FileName Format(Date)

        return dateFormatter
    }
    
    let fileName = "BR_\(dateFormatter.string(from: Date())).brf"   // FileName Format
    let fileURL = docPath.appendingPathComponent(fileName)

    let textString = NSString(string: brtData)
    
    try? textString.write(to: fileURL, atomically: true, encoding: String.Encoding.ascii.rawValue)
    return fileName
}

public func loadTextFromCSV() -> [DataStruct] {
    let dirPath: URL = docPath.appendingPathComponent("data")
    let csvPath: URL = dirPath.appendingPathComponent("dataFile.csv")
    
    parseCSV(at: csvPath, datas: &dataTexts)
    return dataTexts
}

private func parseCSV(at filePath: URL, datas: inout [DataStruct]) {
    datas.removeAll()
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

func deleteCSV(at filePath: URL) {
    do {
        try fManager.removeItem(at: filePath)
    } catch let error {
        print(error.localizedDescription)
    }
}

public func createCSV() {
    var commaText = ""
    
    let folderName = "data"
    let csvFileName = "dataFile.csv"
    
    let dirPath = docPath.appendingPathComponent(folderName)
    
    do {
        try fManager.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
    } catch let error {
        print("Folder Creation Failed: \(error.localizedDescription)")
    }
    
    let filePath = dirPath.appendingPathComponent(csvFileName)
    
    for data in dataTexts {
        commaText += (data.text + ",")
    }
    if !commaText.isEmpty {
        commaText.removeLast()
        
        let fileData = commaText.data(using: .utf8)
        
        do {
            try fileData?.write(to: filePath)
            print("Writing CSV to \(filePath.path)")
        } catch let error {
            print("CSV File Creation Failed: \(error.localizedDescription)")
        }
        
    } else {
        deleteCSV(at: filePath)
        return
    }
}
