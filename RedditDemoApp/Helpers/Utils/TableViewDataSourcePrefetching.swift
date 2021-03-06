//
//  TableViewDataSourcePrefetching.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import UIKit

final class TableViewDataSourcePrefetching: NSObject, DataSourcePrefetching, UITableViewDataSourcePrefetching {

    var cellCount: Int
    var needsPrefetch: Bool
    var prefetchHandler: (() -> Void)

    init(cellCount: Int, needsPrefetch: Bool, prefetchHandler: @escaping (() -> Void)) {
        self.cellCount = cellCount
        self.needsPrefetch = needsPrefetch
        self.prefetchHandler = prefetchHandler
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        prefetchIfNeeded(for: indexPaths)
    }

}
