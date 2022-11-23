/// Export Braille to Number
/// To Arduino

import Foundation
import KorToBraille  

let brailleList = " ⠁⠂⠃⠄⠅⠆⠇⠈⠉⠊⠋⠌⠍⠎⠏⠐⠑⠒⠓⠔⠕⠖⠗⠘⠙⠚⠛⠜⠝⠞⠟⠠⠡⠢⠣⠤⠥⠦⠧⠨⠩⠪⠫⠬⠭⠮⠯⠰⠱⠲⠳⠴⠵⠶⠷⠸⠹⠺⠻⠼⠽⠾⠿"
let brfList = " a1b'k2l@cif/msp\"e3h9o6r^djg>ntq,*5<-u8v.%[$+x!&;:4\\0Z7(_?w]#y)="

/// Braille to Binary Mechanism
/// 0 * * 3
/// 1     4
/// 2     5
///
///     543210
/// 9 = 001001 -> ⠉

public func brailleToInt(_ braille: Character) -> Int {
    var number = 0                        // not supported letter and Init -> 0
    for j in 0..<brailleList.count {
        let index = brailleList.index(brailleList.startIndex, offsetBy: j)
        if braille == brailleList[index] {
            number = j
        }
    }
    
    return number
}

public func brailleToBRF(_ braille: Character) -> Character {
    var brfChar = Character(" ")
    for point in 0..<brailleList.count {
        let index = brailleList.index(brailleList.startIndex, offsetBy: point)
        if braille == brailleList[index] {
            let brfIndex = brfList.index(brfList.startIndex, offsetBy: point)
            brfChar = brfList[brfIndex]
        }
    }
    return brfChar
}


public func transKorBraille(_ text: String) -> String {
    var resultText = KorToBraille.korTranslate(text)
    if resultText != "" && resultText.last != " " {
        resultText.removeLast()
    }
    return resultText
}

