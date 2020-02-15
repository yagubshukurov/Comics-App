//
//  ComicPost.swift
//  February13
//
//  Created by Yagub Shukurov on 2/13/20.
//  Copyright © 2020 Yagub Shukurov. All rights reserved.
//

import Foundation
import SwiftUI

struct ComicsModelAB: Decodable {
    let comicsModel = [ComicPost]()
}

struct ComicPost: Codable, Hashable, Identifiable {
    
    let id = UUID()
    
    let title: String
    let day: String
    let month: String
    let year: String
    let num: Int
    let alt: String
    let img: String
}
