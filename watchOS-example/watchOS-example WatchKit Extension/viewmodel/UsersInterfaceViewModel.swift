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

import Foundation

class UsersInterfaceViewModel : FetchUsersProtocol, UsersViewModelProtocol {
   
    var dataSource: [UserViewModel] = []
    
    private var view: UsersViewProtocol?
    
    private let api : GithubAPI = GithubAPI()
    
    required init(view: UsersViewProtocol){
       self.view = view        
    }
    
    func usersFetched(_ users: [User]?) {
        guard let data = users else { return }
        
        data.forEach {
             dataSource.append(UserViewModel(withUser: $0))
        }
        
        var indexSet = IndexSet()
        
        for index in dataSource.count - data.count..<dataSource.count {
            indexSet.insert(index)
        }
        
        
        view?.invalidate(indexSet)
    }
    
    func loadMore() {
        api.getUsers(dataSource.count, callback: self)
    }
}
