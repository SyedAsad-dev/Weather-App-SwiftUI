//
//  DataSource.swift
//  Data
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import SwiftData
import Domain
import Models

/// A generic async protocol for SwiftData CRUD operations.
public protocol SwiftDataGenericDataSourceProtocol<T> {
    // swiftlint:disable:next type_name
    associatedtype T: PersistentModel & Sendable
    func save(_ model: T) async throws
    func fetchAll() async throws -> [T]
    func deleteAll() async throws
}

@ModelActor
public actor SwiftDataGenericActorDataSource<T: PersistentModel & Sendable>: SwiftDataGenericDataSourceProtocol {
    public func save(_ model: T) async throws {
        modelContext.insert(model)
        try modelContext.save()
        debugPrint("Saved =>>>>>Data")
    }

    public func fetchAll() async throws -> [T] {
        try modelContext.fetch(FetchDescriptor<T>())
    }

    public func deleteAll() async throws {
        let objects = try modelContext.fetch(FetchDescriptor<T>())
        for obj in objects {
            modelContext.delete(obj)
        }
        try modelContext.save()
    }
}

extension SwiftDataGenericActorDataSource where T == WeatherLocalModel {
    public func delete(by id: Int) async throws {
        let allObjects = try modelContext.fetch(FetchDescriptor<WeatherLocalModel>())
        let toDelete = allObjects.filter { $0.id == id }
        for obj in toDelete {
            modelContext.delete(obj)
        }
        try modelContext.save()
        debugPrint("🗑️ Deleted WeatherLocalModel with id \(id)")
    }
}
