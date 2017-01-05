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


class UserInterfaceController: WKInterfaceController, UserViewProtocol {

    var viewModel : UserViewModelProtocol!
    var vm : UserViewModel?
    
    @IBOutlet var name: WKInterfaceLabel!
    @IBOutlet var login: WKInterfaceLabel!
    @IBOutlet var email: WKInterfaceLabel!
    @IBOutlet var since: WKInterfaceLabel!
    @IBOutlet var repos: WKInterfaceLabel!
    
    @IBOutlet var avatar: WKInterfaceImage!
    let watch = WatchConnectivityController.shared

    @IBAction func buttonClick() {
        watch.sendMessage(message: ["user" : vm!.user!.asDict()])
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let user = context as? User {
            viewModel = UserInterfaceViewModel(view: self, withUser: user)
            watch.start()
        }
        
       
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func invalidate(viewModel: UserViewModel) {
        vm = viewModel
        name.setText(viewModel.name)
        login.setText(viewModel.login)
        email.setText(viewModel.email)
        since.setText(viewModel.registerDate)
        repos.setText(viewModel.repos)
        viewModel.showAvatar(imageView: avatar)
    }

}
