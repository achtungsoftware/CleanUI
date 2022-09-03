//  Copyright © 2021 - present Julian Gerhards
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  GitHub https://github.com/knoggl/CleanUI
//

import Foundation

public protocol Api {    
    static func post(_ urlString: String, parameters: [String: String]?) async -> (String, Bool)
    static func postObject<T: Decodable>(_ urlString: String, parameters: [String: String]?, type: T.Type) async -> T?
    static func postObjectArray<T: Decodable>(_ urlString: String, parameters: [String: String]?, type: T.Type) async -> [T]?
    
    static func get(_ urlString: String, parameters: [String: String]?) async -> (String, Bool)
    static func getObject<T: Decodable>(_ urlString: String, parameters: [String: String]?, type: T.Type) async -> T?
    static func getObjectArray<T: Decodable>(_ urlString: String, parameters: [String: String]?, type: T.Type) async -> [T]?
}
