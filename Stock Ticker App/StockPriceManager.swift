//
//  StockPriceManager.swift
//  Stock Ticker App
//
//  Created by Conor Sweeney on 4/25/18.
//  Copyright © 2018 Conor Sweeney. All rights reserved.
//

import UIKit

class StockPriceManager: NSObject {
    var stocks: Array<StockPriceObject> = []
    var jsonDataTask: URLSessionDataTask?
    weak var delegate: StockPriceDelegate?
    
    var queryText = ""
    var lastSearch = ""
    var queryTimer : Timer?
    
    func queryTextChange (text:String){
        self.lastSearch = text
        if self.lastSearch.hasPrefix(self.queryText) && stocks.count == 0 && self.queryText != ""{
            //do nothing
        }
        else if text.count>1{
            if self.queryText != text{
                //valid query
                self.queryTimer?.invalidate()
                self.queryText = text
                queryTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(downloadStockSymbols), userInfo: nil, repeats: false)
            }
        }
        else{
            stocks.removeAll()
            self.delegate?.stockUpdated()
        }
    }
    
    @objc func downloadStockSymbols() {
        //download the json on a background thread
        DispatchQueue.global(qos: .background).async {
            
            //Cancel any previous URLSessionDataTasks so the stocks can't be overriden by a previous call that could be returned later
           self.jsonDataTask?.cancel()
            
            let url = URL(string: "https://symlookup.cnbc.com/symservice/symlookup.do?prefix=\(self.queryText)&partnerid=20064&pgok=1&pgsize=50")
            //Save the new data task in case we need to cancel
            self.jsonDataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let data = data else {
                    //error handling
                    //for now I'll leave this empty
                    print("Error: \(String(describing: error))")
                    return
                }
                
                //parse the json
                self.stocks.removeAll()
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let jsonArr = json as? [Dictionary<String, String>]{
                    for stockDict in jsonArr{
                        //create StockObjects
                        //store symbol names in a dictionary to check for duplicates (constant time)
                        //do not check to see if stocks contains the object since that runs in linear time
                        var stockDuplicateCheck = [String: String]()
                        if let stockName = stockDict["symbolName"]{
                            if stockDuplicateCheck[stockName] == nil{
                                let stock = StockPriceObject.init(stockDict: stockDict, delegate: self.delegate!)
                                self.stocks.append(stock);
                                stockDuplicateCheck[stockName] = "EXISTS!"
                            }
                        }
                    }
                }
                self.delegate?.stockUpdated()
            }
            self.jsonDataTask?.resume()
        }
    }
}
