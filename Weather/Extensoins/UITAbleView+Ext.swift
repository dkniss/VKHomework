//
//  UITAbleView+Ext.swift
//  Weather
//
//  Created by Daniil Kniss on 04.02.2021.
//

import UIKit

extension UITableView {
    func update(deletions: [Int],
                insertion: [Int],
                modifications: [Int],
                sections: Int = 0) {
        beginUpdates()
        deleteRows(at: deletions.compactMap { IndexPath(row: $0,
                                                        section: sections) },
                   with: .automatic)
        insertRows(at: deletions.compactMap { IndexPath(row: $0,
                                                        section: sections) },
                   with: .automatic)
        reloadRows(at: deletions.compactMap { IndexPath(row: $0,
                                                        section: sections) },
                   with: .automatic)
        endUpdates()
    }
    
}
