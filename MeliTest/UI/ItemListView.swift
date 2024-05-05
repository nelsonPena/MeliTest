import SwiftUI

/// Vista que muestra una lista de resultados.
struct ItemListView: View {
    
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @ObservedObject var viewModel: ItemListViewModel
    private let createItemListDetailView: CreateItemListDetailView
    @State private var isDetailViewPresented = false
    @State private var showModal = false
    
    init(viewModel: ItemListViewModel, createItemListDetailView: CreateItemListDetailView) {
        self.viewModel = viewModel
        self.createItemListDetailView = createItemListDetailView
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                contentView
                    .navigationTitle("text_title".localized)
                    .searchable(
                        text: $viewModel.searchText,
                        placement: .navigationBarDrawer(
                            displayMode: .always
                        ),
                        prompt: "text_search_item".localized
                    )
            }
        }
        .onChange(of: viewModel.searchText) { newValue in
            viewModel.searchItemsInServer(searchText: newValue)
        }
        .refreshable {
            viewModel.setup()
        }
        .environment(\.locale, .init(identifier: "es"))
        .accentColor(.black)
    }
    
    // MARK: - Subviews
    
    /// Vista de carga que se muestra mientras se obtienen los datos.
    private var loadingView: some View {
        HStack(spacing: 10) {
            ProgressView().progressViewStyle(.circular)
            Text(viewModel.loaderMensaje)
        }
    }
    
    /// Vista principal que muestra la lista de resultados o un mensaje de error.
    private var contentView: some View {
        if viewModel.showErrorMessage == nil {
            if viewModel.showLoadingSpinner {
                return AnyView(loadingView)
            } else {
                return AnyView(itemList)
            }
        } else {
            return AnyView(errorMessageView(viewModel: viewModel) {
                viewModel.setup()
            })
        }
    }
    
    /// Vista de cuadrícula que muestra la lista de resultados.
    private var itemList: some View {
        List {
            ForEach($viewModel.itemList, id: \.title) { item in
                NavigationLink(destination:  createItemListDetailView.create(with: item.wrappedValue)) {
                    ItemView(viewModel: viewModel, item: item.wrappedValue).frame(maxWidth: .infinity)
                }
            }
            .padding(15)
        }.scrollDismissesKeyboard(.interactively)
    }
    
    /// Vista que muestra un mensaje de error.
    struct errorMessageView: View  {
        @State var viewModel: ItemListViewModel
        let action: () -> Void
        
        var body: some View {
            Spacer()
            Button(action: action) {
                Text(viewModel.showErrorMessage!)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 30)
            }.foregroundColor(.red)
                .font(.system(size: 24, weight: .bold))
                .background(.red.opacity(0.5))
                .cornerRadius(12)
                .frame(maxWidth: .infinity)
                .padding()
                .lineLimit(1)
        }
    }
}

// MARK: - Preview

struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        ItemListFactory().create()
    }
}
