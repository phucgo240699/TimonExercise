//
//  SearchBoard.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/31/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension ListBoardViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.boards = CustomBoard.shared.getBoardsByTitle(by: text)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
