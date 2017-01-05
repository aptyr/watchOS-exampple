/*
 * Copyright (C) 2017 Aptyr (github.com/aptyr)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import WatchKit
import Foundation


class UsersInterfaceController: WKInterfaceController, UsersViewProtocol {

    private var viewModel: UsersViewModelProtocol!
    
    @IBOutlet var table: WKInterfaceTable!
    
    @IBAction func loadMore() {
        viewModel.loadMore()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        table.setNumberOfRows(0, withRowType: "UserRow")
        
        viewModel = UsersInterfaceViewModel(view: self)
        
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        presentController(withName: "User", context: viewModel.dataSource[rowIndex].user)
    }
    
    func invalidate(_ indexSet: IndexSet) {
        table.insertRows(at: indexSet, withRowType: "UserRow")
        
        for index in 0..<table.numberOfRows {
            guard let controller = table.rowController(at: index) as? UserRowController else { continue }
            
            controller.invalidate(viewModel: viewModel.dataSource[index])
        }
    }

}
