import SwiftUI

struct ItemView: View {
    @StateObject private var viewModel = ItemViewModel()
    
    var body: some View {
        List {
            if viewModel.isLoading {
                ForEach(0..<4, id: \.self) { _ in
                    LoadingPlaceholderView()
                }
            } else {
                ForEach(viewModel.strings, id: \.self) { string in
                    Text(string)
                }
            }
        }
        .onAppear {
            viewModel.loadStrings()
        }
    }
}

#Preview {
    ItemView()
}
