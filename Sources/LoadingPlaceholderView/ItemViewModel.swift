import Foundation

class ItemViewModel: ObservableObject {
    @Published var strings: [String] = []
    @Published var isLoading: Bool = true
    
    func loadStrings() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.strings = ["Apple", "Banana", "Cherry", "Date"]
            self.isLoading = false
        }
    }
}
