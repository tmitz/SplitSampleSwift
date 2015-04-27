//
//  HatenaBookmarkRSSParser.swift
//  SplitAndPopover
//
//  Created by Tomohiro Mitsumune on 2015/04/24.
//  Copyright (c) 2015年 tmitsumune. All rights reserved.
//

// TODO: 実験ライブラリ

import UIKit

class HatenaBookmarkRSSParser: NSObject, NSXMLParserDelegate {

    // MARK: Properties
    
    var arrParsedData = [[String:String]]()
    var currentDataDictionary = [String:String]()
    var currentElement = ""
    var foundCharacters = ""
    
    var delegate: XMLParserDelegate?
    
    // MARK:: Convinience
    
    func startParsingWithContentsURL(rssURL: NSURL!) {
        let parser = NSXMLParser(contentsOfURL: rssURL)
        parser?.delegate = self
        parser?.parse()
    }
    
    // MARK:: NSXMLParserDelegate
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentElement = elementName
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if currentElement == "title" {
            foundCharacters += string!
            println(foundCharacters)
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
            if elementName == "link" {
                foundCharacters = (foundCharacters as NSString).substringFromIndex(3)
            }
            currentDataDictionary[currentElement] = foundCharacters
            foundCharacters = ""
            if currentElement == "title" {
                arrParsedData.append(currentDataDictionary)
            }
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        println(arrParsedData)
        delegate?.parsingWasFinished()
    }
    
    // MARK: Error handling
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        println(parseError.description)
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        println(validationError.description)
    }
    
}
