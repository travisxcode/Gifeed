// @copyright Gifeed by TrevisXcode

import ComposableArchitecture
import SwiftUI

@Reducer
struct WaterfallGrid {
  @ObservableState
  struct State {
    struct Column: Identifiable {
      let id = UUID()
      var items = [GifItem.State]()
    }
    
    var columns: [Column] = []
    var spacing: CGFloat = 10
    var horizontalPadding: CGFloat = 10
    
    init(
      items: [GifItem.State] = [],
      numOfColumns: Int = 1,
      spacing: CGFloat = 10,
      horizontalPadding: CGFloat = 10
    ) {
      self.spacing = spacing
      self.horizontalPadding = horizontalPadding
      self.columns = ColumnBuilder.build(numOfColumns: numOfColumns, items: items)
    }
  }
  
}

struct WaterfallGridView: View {
  var store: StoreOf<WaterfallGrid>
  
  var body: some View {
    HStack(alignment: .top, spacing: store.spacing) {
      ForEach(store.columns) { column in
        LazyVStack(spacing: store.spacing) {
          ForEach(column.items) { item in
            GifItemView(store: Store(initialState: item) {
              GifItem()
            })
            .frame(height: itemWidth * (item.height / item.width))
          }
        }
      }
    }
    .padding(.horizontal, store.horizontalPadding)
  }
  
  private var screenWidth: CGFloat {
    UIScreen.main.bounds.width
  }
  
  private var itemWidth: CGFloat {
    (screenWidth - totalPadding) / Double(store.columns.count)
  }
  
  private var totalPadding: CGFloat {
    store.spacing * Double(store.columns.count)
  }
}

extension WaterfallGrid {
  struct ColumnBuilder {
    static func build(
      numOfColumns: Int,
      items: [GifItem.State]
    ) -> [WaterfallGrid.State.Column] {
      var columns = [WaterfallGrid.State.Column]()
      for _ in 0..<numOfColumns {
        columns.append(WaterfallGrid.State.Column())
      }
      
      var columnsHeight = Array<CGFloat>(
        repeating: 0,
        count: numOfColumns
      )
      
      for item in items {
        var smallestColumnIndex = 0
        var smallestHeight = columnsHeight.first!
        for i in 1..<columnsHeight.count {
          let curHeight = columnsHeight[i]
          if curHeight < smallestHeight {
            smallestHeight = curHeight
            smallestColumnIndex = i
          }
        }
        
        columns[smallestColumnIndex].items.append(item)
        columnsHeight[smallestColumnIndex] += item.height
      }
      
      return columns
    }
  }
}
