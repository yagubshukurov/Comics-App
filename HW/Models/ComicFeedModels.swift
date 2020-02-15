//
//  ComicFeedModels.swift
//  February13
//
//  Created by Yagub Shukurov on 2/14/20.
//  Copyright © 2020 Yagub Shukurov. All rights reserved.
//

import Foundation

class ComicFeed: ObservableObject, RandomAccessCollection {
    
    typealias Element = ComicPost
    
    @Published var comicListItems = [ComicPost]()
    
    var latestNum: Int = 0
    
    var startIndex: Int { comicListItems.startIndex }
    var endIndex: Int { comicListItems.endIndex }
    
    var urlBase = "https://xkcd.com/"
    
    init() {
        loadMoreComics()
    }
    
    subscript(position: Int) -> ComicPost {
        return comicListItems[position]
    }
    
    var loadStatus = LoadStatus.ready(nextPage: 2268)
    
    func loadMoreComics(currentItem: ComicPost? = nil) {
        
        if !shouldLoadMoreData(currentItem: currentItem) {
            return
        }
        guard case let .ready(page) = loadStatus else {
            return
        }
        loadStatus = .loading(page: page)
        
        let urlString = "\(urlBase)\(page)/info.0.json"
        
        // can be written more efficiently
        //        if currentItem == nil {
        //        }
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: parseComicsFromResponse(data:response:error:))
        task.resume()
    }
    
    func shouldLoadMoreData(currentItem: ComicPost? = nil) -> Bool {
        guard let currentItem = currentItem else {
            return true
        }
        
        for n in (comicListItems.count - 4)...(comicListItems.count - 1) {
            if n >= 0 && currentItem.id == comicListItems[n].id {
                return true
            }
        }
        return false
    }
    
    func parseComicsFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            loadStatus = .parseError
            return
        }
        guard let data = data else {
            print("No data found")
            loadStatus = .parseError
            return
        }
        
        let newComics = parseComicsFromData(data: data)
        DispatchQueue.main.async {
            self.comicListItems.append(contentsOf: newComics)
            if newComics.count == 0 {
                self.loadStatus = .done
            } else {
                guard case let .loading(page) = self.loadStatus else {
                    fatalError("loadSatus is in a bad state")
                }
                self.loadStatus = .ready(nextPage: page - 1)
            }
        }
    }
    
    func parseComicsFromData(data: Data) -> [ComicPost] {
        var response: ComicPost
        do {
            response = try JSONDecoder().decode(ComicPost.self, from: data)
        } catch {
            print("Error parsing the JSON: \(error)")
            return []
        }
        
        return [response]
    }
    
    enum LoadStatus {
        case ready (nextPage: Int)
        case loading (page: Int)
        case parseError
        case done
    }
    
    func getLastNum() {
        guard let url = URL(string: "https://xkcd.com/info.0.json") else { fatalError("URL is not working") }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let latestComic = try! JSONDecoder().decode(MaxComicNum.self, from: data!)
            DispatchQueue.main.async {
                self.latestNum = latestComic.num
                print(self.latestNum)
            }
        }.resume()
    }
    
}
