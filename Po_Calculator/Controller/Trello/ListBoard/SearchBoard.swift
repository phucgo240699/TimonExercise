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
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        FethAndReload()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            if text.isEmptyOrSpaceing() == false {
                self.boards = CustomBoard.shared.getBoardsByTitle(by: text)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            else {
                searchBar.text = nil
                FethAndReload()
            }
        }
    }
}
