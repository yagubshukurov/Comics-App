//
//  ComicRow.swift
//  February13
//
//  Created by Yagub Shukurov on 2/13/20.
//  Copyright © 2020 Yagub Shukurov. All rights reserved.
//

import SwiftUI

struct ComicRow: View {
    
    var comic: ComicPost
    
    var body: some View {
        HStack {
            UrlImageView(urlString: comic.img)
            .frame(width: 75, height: 75)
            VStack (alignment: .leading) {
                Text(comic.title)
                    .font(.headline)
                Text("\(comic.year)-\(comic.month)-\(comic.day)")
                    .font(.subheadline)
                Spacer()
            }
            
        }
    }
}
