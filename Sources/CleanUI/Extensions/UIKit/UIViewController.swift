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

import SwiftUI
import Combine

public extension UIViewController {
    
    /// Finds `UIViewController` children from a specific type
    /// - Returns: An `Array` of `UIViewController` children
    func findChilds<T: UIViewController>(subclassOf: T.Type) -> [T] {
        return recursiveChild.compactMap { $0 as? T }
    }
    
    var recursiveChild: [UIViewController] {
        return children + children.flatMap { $0.recursiveChild }
    }
    
    /// Trys to find the first `UINavigationController` in `UIViewController` children
    var findFirstUINavigationController: UINavigationController? {
        let arr = self.findChilds(subclassOf: UINavigationController.self)
        
        if arr.count > 0 {
            return arr[0]
        }
        
        return nil
    }
}
