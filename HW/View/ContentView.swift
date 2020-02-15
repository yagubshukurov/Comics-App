//
//  ContentView.swift
//  February13
//
//  Created by Yagub Shukurov on 2/13/20.
//  Copyright © 2020 Yagub Shukurov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var posts: [ComicPost] = []
    @State var search = ""
    
    @ObservedObject var comicsFeed = ComicFeed()
    
    var body: some View {
        
        NavigationView {
            VStack {
                SearchBar(text: $search)
                List(comicsFeed.comicListItems.filter { self.search.isEmpty ? true : $0.title.localizedCaseInsensitiveContains(self.search) }) { (comic: ComicPost) in
                    NavigationLink(destination: ComicDetail(comic: comic)) {
                        ComicRow(comic: comic)
                        
                    }.accessibility(identifier: "ComicFeedList")
                        .onAppear {
                            self.comicsFeed.loadMoreComics(currentItem: comic)
                    }
                }
            }.navigationBarTitle("xkcd")
        }
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
