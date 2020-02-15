//
//  ComicDetail.swift
//  February13
//
//  Created by Yagub Shukurov on 2/13/20.
//  Copyright © 2020 Yagub Shukurov. All rights reserved.
//

import SwiftUI

struct ComicDetail: View {
    
    var comic: ComicPost
    
    var body: some View {
        VStack() {
            Text(String(comic.title))
                .font(.title)
                .accessibility(identifier: "ComicTitle")
            UrlImageView(urlString: comic.img)
                .edgesIgnoringSafeArea(.top)
                .frame(width: 400, height: 400)
                .accessibility(identifier: "ComicImage")
            Text(comic.alt)
                .font(.subheadline)
                .accessibility(identifier: "ComicAltText")
            Spacer()
        }.padding()
        
    }
}
