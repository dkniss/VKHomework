//
//  UICollectionView+Ext.swift
//  Weather
//
//  Created by Daniil Kniss on 07.02.2021.
//

import UIKit

extension UICollectionView {
    
    func update(deletions: [Int],
                insertions: [Int],
                modifications: [Int],
                sections: Int = 0) {
        performBatchUpdates({
            deleteItems(at: deletions.compactMap { IndexPath(row: $0,
                                                             section: sections) })
            insertItems(at: insertions.compactMap { IndexPath(row: $0,
                                                              section: sections) })
            reloadItems(at: modifications.compactMap { IndexPath(row: $0,
                                                              section: sections) })
        })
    }
    
//        beginUpdates()
//        deleteRows(at: deletions.compactMap { IndexPath(row: $0,
//                                                        section: sections) },
//                   with: .automatic)
//        insertRows(at: insertion.compactMap { IndexPath(row: $0,
//                                                        section: sections) },
//                   with: .automatic)
//        reloadRows(at: modifications.compactMap { IndexPath(row: $0,
//                                                        section: sections) },
//                   with: .automatic)
//        endUpdates()
    }
    

