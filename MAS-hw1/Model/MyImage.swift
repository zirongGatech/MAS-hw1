//
//  Image.swift
//  MAS-hw1

//
//  Created by Ren Liu on 9/11/21.
//

import Foundation
import SwiftUI

struct MyImage: Identifiable {
    var id: String = UUID().uuidString
    var author: String
    var uploadTime: String
    var filename: String
//    var down: DownloadImageViewModel
}
