//
//  ContextMenu.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/28/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension DetailBoardViewController {

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            
            let delete = UIAction(title: "Delete list", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                
                guard let board = self.board else {
                    return
                }
                CustomList.shared.deleteList(index: indexPath.row, board: board)

                self.lists.removeAll()
                
                self.lists = CustomList.shared.getListsSorting(board: board, by: "id", ascending: true)
                

                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
            
            let edit = UIAction(title: "Edit list's name", image: UIImage(systemName: "slider.horizontal.3")) { _ in
                
                let alert = UIAlertController(title: "Edit name", message: nil, preferredStyle: .alert)
                var textField : UITextField = UITextField()
                textField.text = self.lists[indexPath.row].name
                
                let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
                    if let text = textField.text, let board = self.board {
                        if text.isEmptyOrSpaceing() == false {
                            CustomList.shared.updateList(index: indexPath.row, board: board, name: text)
                            
                            DispatchQueue.main.async {
                                collectionView.reloadItems(at: [indexPath])
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
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete, edit])
        }
        
        return configuration
    }
}
