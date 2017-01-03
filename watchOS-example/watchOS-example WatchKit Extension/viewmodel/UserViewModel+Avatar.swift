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
import WatchKit
import Kingfisher

extension UserViewModel {
    func showAvatar(imageView view: WKInterfaceImage){
        if let url = user?.avatar_url {
            _ = KingfisherManager.shared.retrieveImage(with: URL(string: url)!, options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) -> () in
                view.setImage(image)
            }
        }
        
    }
}
