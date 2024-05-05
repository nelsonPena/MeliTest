//
//  ItemDetailView.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemDetailView: View {
    
    @ObservedObject private var viewModel: ItemDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(viewModel: ItemDetailViewModel, viewData: ItemListPresentableItem) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top) {
            if viewModel.showLoadingSpinner {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                // Item Details
                VStack() {
                    ScrollView {
                        VStack(alignment: .center, spacing: 20) {
                            // Item Image
                            itemImage
                            // Item Name
                            itemName
                            // Details
                            itemDetaisTitle
                            DetailRow(label: "text_attributes_condition".localized,
                                      value: viewModel.ItemDetailPresentable.condition,
                                      isStatus: false,
                                      color: .cyan)
                            ForEach(getAttributes(), id: \.name) { attribute in
                                DetailRow(label: attribute.name,
                                          value: attribute.valueName,
                                          isStatus: false,
                                          color: .cyan)
                            }
                        }
                        .padding(20)
                    }
                    Spacer()
                    DoneButton(action: { self.presentationMode.wrappedValue.dismiss() })
                }.padding(20)
            }
        }
        .navigationBarTitle("detail_title".localized)
        .navigationBarTitleDisplayMode(.large)
        .onReceive(viewModel.$goBack) { goBack in
            if goBack {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    var itemImage: some View {
        WebImage(url: URL(string: viewModel.ItemDetailPresentable.thumbnail))
            .resizable()
            .placeholder(Image(systemName: "photo"))
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(maxWidth: 200,
                   alignment: .center)
            .cornerRadius(8.0)
    }
    
    var itemName: some View {
        Text(viewModel.ItemDetailPresentable.title)
            .font(.system(size: 30, weight: .bold))
            .accessibilityIdentifier("nameLabel")
            .frame(maxWidth: .infinity,
                   alignment: .center)
            .foregroundColor(.black)
    }
    
    var itemDetaisTitle: some View {
        Text("text_attributes_title".localized)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(
                .system(
                    size: 21,
                    weight: .bold
                )
            )
    }
    
    func getAttributes() -> [AttributePresentableItem] {
        viewModel.ItemDetailPresentable.attributes
    }
    
}

// MARK: - Detail Row View

struct DetailRow: View {
    let label: String
    let value: String
    let isStatus: Bool
    let color: Color
    
    var body: some View {
        HStack {
            Text(label)
                .accessibilityIdentifier("text_\(label.lowercased())")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .bold))
            
            Text(value)
                .accessibilityIdentifier("value_\(label.lowercased())")
                .foregroundColor(color)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Done Button View

struct DoneButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("text_done_button".localized)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
        .accessibilityIdentifier("doneButton")
        .padding()
        .foregroundColor(.white)
        .background(.black)
        .cornerRadius(100)
    }
}
