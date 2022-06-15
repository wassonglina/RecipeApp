//
//  Created by Lina on 5/30/22.
//

import XCTest
@testable import Fetch_Coding_Challenge_Lina

class DetailViewModelTests: XCTestCase {

    func testSanitizingInstructions() {

        let instruction = "In the bowl  add warm water and yeast.\r\n\r\n\r\nAllow to sit until frothy.\r\n\r\nInto the same bowl, add eggs and salt.\r\nWhisk until combined."

        let sanitizedInstruction = DetailViewModel.sanitizeInstruction(with: instruction)

        let result = "In the bowl add warm water and yeast.\n\nAllow to sit until frothy.\n\nInto the same bowl, add eggs and salt.\n\nWhisk until combined."

        XCTAssertEqual(sanitizedInstruction, result)
    }
}
