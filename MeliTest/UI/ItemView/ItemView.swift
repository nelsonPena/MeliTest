//
//  ItemListPresentableItem.swift
//  MeliTest
//
//  Created by Nelson Geovanny Pena Agudelo on 14/10/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct ItemView: View {
    
    @State var itemDetail: ItemListPresentableItem?
    @State private var cancellables: Set<AnyCancellable> = Set()
    @State var viewModel: ItemListViewModel
    let dimensions: Double = 140
    let item: ItemListPresentableItem
    
    var body: some View {
        HStack{
            Text(item.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            itemImage
        }.padding(10)
    }
    
    
    var itemImage: some View {
        WebImage(url: URL(string: item.thumbnail))
            .resizable()
            .placeholder(Image(systemName: "Character"))
            .placeholder {
                Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 50, height: 50, alignment: .center)
            .cornerRadius(8.0)
    }
}



