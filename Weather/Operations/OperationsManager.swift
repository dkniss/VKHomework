//
//  OperationsManager.swift
//  Weather
//
//  Created by Daniil Kniss on 11.03.2021.
//

import Foundation

final class OperationsManager {
    var operationInProgress = [IndexPath: Operation]()
    
    let filteringQ: OperationQueue = {
        let q = OperationQueue()
        q.maxConcurrentOperationCount = 2
        q.name = "filtering"
        q.qualityOfService = .userInitiated
        return q
    }()
}
