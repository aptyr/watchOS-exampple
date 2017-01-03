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
import WatchConnectivity

class WatchConnectivityController : NSObject, WCSessionDelegate {
 
    static let shared = WatchConnectivityController()
    private var userHandler: ((Dictionary<String, Any>) -> ())?
    
    private override init(){
        super.init()
    }
    
    var session: WCSession? {
        
        let session: WCSession? = WCSession.isSupported() ? WCSession.default() : nil
        
        #if os(iOS)
            if let session = session {
                return session
            }
        #elseif os(watchOS)
            return session
        #endif
        return nil
    }
    
    #if os(iOS)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    
    #endif
    
    #if os(watchOS)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    #endif
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let dict = message["user"], let handler = userHandler{
            handler(dict as! Dictionary<String, Any>)
        }
    }
    
    func sendMessage(message: [String : Dictionary<String, Any>],
                     replyHandler: (([String : Any]) -> Void)? = nil,
                     errorHandler: ((Error) -> Void)? = nil)
    {
        session?.sendMessage(message, replyHandler: replyHandler, errorHandler: errorHandler)
    }
    
    func start(){
        session?.delegate = self
        session?.activate()
    }
    
    func userHandler(handler:  @escaping (Dictionary<String, Any>) -> ()){
        self.userHandler = handler
    }

    
}
