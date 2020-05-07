//
//  NetworkingService.swift
//  RSSFeedReader
//
//  Created by Munara on 5/6/20.
//  Copyright © 2020 Munara. All rights reserved.
//

import Foundation



class ItemsParser: NSObject {
    
    private var items: [RSSItem] = []
    private var currentElement = ""
       
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentDescription: String = "" {
           didSet {
               currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
       
    func requestItems(_ urlPath: String,
                      completion: @escaping([RSSItem]) -> Void) {
        
        self.parserCompletionHandler = completion
        
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let data = data {
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
        }
        task.resume()
    }
}
extension ItemsParser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
        }
    }
    
    func parser(_ parser: XMLParser,
                foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        case "description" : currentDescription += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        if elementName == "item" {
            let item = RSSItem(title: currentTitle, description: currentDescription)
            self.items.append(item)
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(items)
    }
    
    func parser(_ parser: XMLParser,
                parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
}
