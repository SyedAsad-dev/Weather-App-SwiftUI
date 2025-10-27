//
//  HTTPTask.swift
//  Data
//
//  Created by Rizvi Naqvi on 18/10/2025.
//

import Foundation
import UIKit

public typealias HTTPHeaders = [String: String]

public var defaultHeaders: HTTPHeaders {
        var header = HTTPHeaders()
        header["Content-Type"] = "application/json"
        return header
}

public enum HTTPTask {
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
}
