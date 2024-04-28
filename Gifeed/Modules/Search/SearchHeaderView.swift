// @copyright Gifeed by TrevisXcode

import SwiftUI

struct SearchHeaderView: View {
  var body: some View {
    HStack {
      Image(systemName: "magnifyingglass")
        .resizable()
        .frame(width: 18, height: 18)
        .padding(.leading)
        .foregroundColor(.gray)
      Text("Search Giphy")
        .font(.body)
      Spacer()
    }
    .frame(height: 34)
    .background(Color.gray.opacity(0.3))
    .cornerRadius(12)
    .foregroundColor(.gray)
    .padding([.leading, .trailing], 10)
  }
}

#Preview {
  SearchHeaderView()
}
