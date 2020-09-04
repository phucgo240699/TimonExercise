//
//  ContextMenu.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 9/2/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension ListBoardViewController {
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (_) -> UIMenu? in
            let edit = UIAction(title: "Edit name", image: UIImage(systemName: "slider.horizontal.3")) { (_) in
                let alert = UIAlertController(title: "Edit name", message: "", preferredStyle: .alert)
                var textField : UITextField = UITextField()
                textField.text = self.boards[indexPath.row].title
                
                let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
                    if let text = textField.text, let thumbnail = self.boards[indexPath.row].thumbnail {
                        if text.isEmptyOrSpaceing() == false {
                            CustomBoard.shared.updateBoard(index: indexPath.row, thumbnail: thumbnail, title: text)
                            
                            DispatchQueue.main.async {
                                tableView.reloadData()
                            }
                        }
                    }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
                    
                }

                alert.addTextField { (alertTextField) in
                    alertTextField.text = textField.text
                    textField = alertTextField
                }
                alert.addAction(saveAction)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true, completion: nil)
                
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [edit])
        }
        
        return configuration
    }
}
