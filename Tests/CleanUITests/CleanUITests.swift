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

import XCTest
@testable import CleanUI

final class CleanUITests: XCTestCase {
    func test_CUTime() throws {
        XCTAssertEqual(CUTime.verifiyDateTimeString(timestamp: "2022-06-11T10:56:45"), "2022-06-11T10:56:45")
        XCTAssertEqual(CUTime.verifiyDateTimeString(timestamp: "2022-05-11 00:54:06"), "2022-05-11T00:54:06")
    }
}
