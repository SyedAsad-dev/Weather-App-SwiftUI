//
//  DataStates.swift
//  Utils
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import Foundation

public enum DataStates: Hashable {
    case loading
    case finished(Outcome)
    public enum Outcome: Hashable {
        case success
    }

}

public typealias DataState =  Result<DataStates, GenericError>
