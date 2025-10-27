//
//  FavoriteView.swift
//  Favorite
//
//  Created by Rizvi Naqvi on 21/10/2025.
//

import SwiftUI

public struct FavoriteView: View {
    @State var viewModel: FavoriteViewModel
    @State private var router: FavoriteScreenRouterProtocol
    @State private var newCityName: String = ""
    
    public init(
        viewModel: FavoriteViewModel,
        router: FavoriteScreenRouterProtocol
    ) {
        self.viewModel = viewModel
        _router = State(initialValue: router)
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            // Top Input Row
            HStack {
                TextField("Enter city name", text: $newCityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, 8)
                
                Button(action: addCity) {
                    Label("Add", systemImage: "plus.circle.fill")
                        .labelStyle(.titleAndIcon)
                }
                .buttonStyle(.borderedProminent)
                .disabled(newCityName.isEmpty)
            }
            .padding(.horizontal)
            
            // City List
            List {
                ForEach(viewModel.favoriteList) { favorite in
                    HStack(spacing: 0) {
                        
                        Button(action: {
                            router.openMap(data: viewModel.mappingEntityToMap(items: [favorite]))
                        }) {
                            HStack {
                                favorite.main.icon
                                    .resizable().frame(width: 30,height: 30).padding(5).background(favorite.main.assetColor).cornerRadius(5)
                                Text(favorite.name)
                                    .font(.headline)
                                
                                Text(favorite.temp)
                                    .font(.caption)
                                
                                Spacer()
                                
                            }
                        }
                       
                        Button(action: {
                            deleteCity(at: favorite.id)
                        }) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        .buttonStyle(.plain)
                    }.padding(.vertical, 4)
                        
                    
                }
            }.listStyle(.insetGrouped)
           
        }.toast(isPresented: $viewModel.showAlert, message: viewModel.presentableError).onViewDidLoad {
            viewModel.requestData()
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: navigateToMap) {
                    Image(systemName: "map.fill")
                        .imageScale(.large)
                }
                .accessibilityLabel("Open Map")
            }
        }
    }
    
    private func addCity() {
        viewModel.addFavoriteRequest(query: newCityName)
        newCityName = ""
    }
    
    private func deleteCity(at id: Int) {
        viewModel.removeFavoriteRequest(id: id)
    }
    private func navigateToMap() {
        router.openMap(data: viewModel.mappingEntityToMap())
    }
}
