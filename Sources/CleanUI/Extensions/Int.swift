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

public extension Int {
    func abbreviate() -> String {
        let numFormatter = NumberFormatter()
        
        typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
        let abbreviations:[Abbrevation] = [
            (0, 1, ""),
            (1000.0, 1000.0, CULanguage.getStringCleanUI("thousandabbreviation")),
            (1_000_000.0, 1_000_000.0, CULanguage.getStringCleanUI("millionabbreviation")),
            (100_000_000.0, 1_000_000_000.0, CULanguage.getStringCleanUI("billionabbreviation"))
        ]
        
        let startValue = Double (abs(self))
        let abbreviation: Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        } ()
        
        let value = Double(self) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1
        
        return numFormatter.string(from: NSNumber (value:value)) ?? "0"
    }
}

struct IntAbbreviate_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            Text("\(800.abbreviate())")
            Text("\(999.abbreviate())")
            Text("\(1001.abbreviate())")
            Text("\(1200.abbreviate())")
            Text("\(3424432.abbreviate())")
            Text("\(34444.abbreviate())")
            Text("\(543654375.abbreviate())")
            Text("\(6543653465346.abbreviate())")
            Text("\(140750.abbreviate())")
        }
    }
}
