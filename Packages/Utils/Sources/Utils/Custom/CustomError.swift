//
//  CustomError.swift
//  Utils
//
//  Created by Rizvi Naqvi on 19/10/2025.
//

import Foundation

public enum GenericError: Error, Equatable {
    case mappingFailed
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case somethingWentWrong
    case invalidData(String)
    case authorizationDenied
    case locationUnavailable
    case internetNotAvailable
    case unknownError
}

extension GenericError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidData(let message):
            return "\(message)"
        case .authorizationDenied:
            return "Error \n Request has been denied"
        case .locationUnavailable:
            return "Error \n Location Unavailable"
        case .mappingFailed:
            return "Error \n Decoding issue"
        case .authenticationError:
            return "Error \n Token has Expired"
        case .badRequest:
            return "Error \n Bad Request"
        case .outdated:
            return "Error \n Outdated"
        case .failed:
            return "Error \n Request has failed"
        case .noData:
            return "Error \n No Data has found"
        case .internetNotAvailable:
            return "No Internet \n check you internet connection"
        default:
            return "Error \n Something went Wrong"
        }
    }
}
