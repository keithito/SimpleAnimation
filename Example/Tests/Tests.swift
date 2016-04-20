// https://github.com/Quick/Quick

import Quick
import Nimble
import SimpleAnimation

class TableOfContentsSpec: QuickSpec {
  override func spec() {
    describe("write") {
      context("some") {
        it("tests") {
          expect(23) == 23
        }
      }
    }
  }
}
