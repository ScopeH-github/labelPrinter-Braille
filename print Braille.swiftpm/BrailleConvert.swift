import Foundation

let brailleList = " ⠁⠂⠃⠄⠅⠆⠇⠈⠉⠊⠋⠌⠍⠎⠏⠐⠑⠒⠓⠔⠕⠖⠗⠘⠙⠚⠛⠜⠝⠞⠟⠠⠡⠢⠣⠤⠥⠦⠧⠨⠩⠪⠫⠬⠭⠮⠯⠰⠱⠲⠳⠴⠵⠶⠷⠸⠹⠺⠻⠼⠽⠾⠿"

/// Braille to Binary Mechanism
/// 0 * * 3
/// 1     4
/// 2     5
///
///     543210
/// 9 = 001001 -> ⠉
public func brailleToInt(_ braille: Character) -> Int {
    var number = 0
    for j in 0..<brailleList.count {
        let index = brailleList.index(brailleList.startIndex, offsetBy: j)
        if braille == brailleList[index] {
            number = j
        }
    }
    
    return number
}
