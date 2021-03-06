// https://lostmoa.com/blog/ScrollListToRowInSwiftUI/

import SwiftUI

struct ScrollManagerView: UIViewRepresentable {
    
    @Binding var indexPathToSetVisible: IndexPath?
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let indexPath = indexPathToSetVisible else { return }
        let superview = uiView.findViewController()?.view
        
        if let tableView = superview?.subview(of: UITableView.self) {
            if tableView.numberOfSections > indexPath.section &&
                tableView.numberOfRows(inSection: indexPath.section) > indexPath.row {
                tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
        
        DispatchQueue.main.async {
            self.indexPathToSetVisible = nil
        }
    }
}

