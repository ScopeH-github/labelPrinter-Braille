//
//  HiddenKeyboard.swift
//  braillePrint
//
//  Created by 홍종언 on 2022/11/24.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
