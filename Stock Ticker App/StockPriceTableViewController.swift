//
//  StockPriceTableViewController.swift
//  Stock Ticker App
//
//  Created by Conor Sweeney on 4/25/18.
//  Copyright © 2018 Conor Sweeney. All rights reserved.
//

import UIKit

class StockPriceTableViewController: UITableViewController, UISearchBarDelegate, StockPriceDelegate {
   
    @IBOutlet weak var searchBar: UISearchBar!
    var stockPriceManager = StockPriceManager()
    var queryTimer: Timer?
    var lastQuery = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stockPriceManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stockPriceManager.stocks.count
    }
    
    // MARK: - Search bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //I am implementing all search logic in the manager so I'll pass along the updated text
        var newText = searchText.replacingOccurrences(of: " ", with: "")
        newText = newText.lowercased()
        self.stockPriceManager.queryTextChange(text: newText)
    }
    
    // MARK: - StockPriceDelegate
    func stockUpdated() {
        //push to main thread to update ui
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stock = self.stockPriceManager.stocks[indexPath.row]
        cell.textLabel?.text = stock.tableViewCellText
        return cell
    }
    
}
