//
//  StockPriceObject.swift
//  Stock Ticker App
//
//  Created by Conor Sweeney on 4/25/18.
//  Copyright © 2018 Conor Sweeney. All rights reserved.
//

import UIKit

//I am using a delegate instead of notifications to avoid the notification center and boost efficiency
//The data is only need in the StockPriceTableViewController so each stock has a 1-1 relationship with it
protocol StockPriceDelegate: class {
    func stockUpdated ()
}

class StockPriceObject: NSObject {
    var companyName = ""
    var symbolName = ""
    var tableViewCellText = ""
    var lastPrice = ""
    weak var delegate: StockPriceDelegate?
    
    init(stockDict:Dictionary<String, String>, delegate: StockPriceDelegate ) {
        super.init()
        
        //I am assuming all the values are strings
        if stockDict["symbolName"] != nil {self.symbolName = stockDict["symbolName"]!}
        if stockDict["companyName"] != nil {self.companyName = stockDict["companyName"]!}
        
        //this will be appended later to add the stock price
        self.tableViewCellText = self.symbolName
        self.delegate = delegate
        
        //now that the symbol name is set lets download the stock price
        downloadStockPrice()
    }
    
    func downloadStockPrice(){
        //Push to a new background thread
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: "https://quote.cnbc.com/quote-html-webservice/quote.htm?symbols=\(self.symbolName)&output=json"){
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data else {
                        //error handling
                        //for now I'll leave this empty
                        print("Error: \(String(describing: error))")
                        return
                    }
                    //parse the json
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDict = json as? Dictionary<String, Any>{
                        if let quickQuoteResult = jsonDict["QuickQuoteResult"] as? Dictionary<String, Any>{
                            if let quickQuote = quickQuoteResult["QuickQuote"] as? Dictionary<String, Any>{
                                if let p = quickQuote["last"]{
                                    self.lastPrice = p as! String
                                    self.tableViewCellText.append(": $\(self.lastPrice)")
                                    self.delegate?.stockUpdated()
                                }
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
}
