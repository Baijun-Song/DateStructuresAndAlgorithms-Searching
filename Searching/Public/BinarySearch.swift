extension RandomAccessCollection where Element: Comparable {
  public func binarySearch(
    returningIndexOf element: Element,
    in range: Range<Index>? = nil
  ) -> Index? {
    let range = range ?? startIndex..<endIndex
    precondition(range.lowerBound < range.upperBound)
    
    var lowerIndex = range.lowerBound
    var upperIndex = range.upperBound
    while lowerIndex < upperIndex {
      let distance = distance(from: lowerIndex, to: upperIndex)
      let middleIndex = index(lowerIndex, offsetBy: distance / 2)
      let middleElement = self[middleIndex]
      if element < middleElement {
        upperIndex = middleIndex
      } else if element == middleElement {
        return middleIndex
      } else {
        lowerIndex = index(after: middleIndex)
      }
    }
    return nil
  }
  
  public func binarySearch(
    returningIndicesOf element: Element,
    in range: Range<Index>? = nil
  ) -> Range<Index>? {
    let range = range ?? startIndex..<endIndex
    precondition(range.lowerBound < range.upperBound)
    guard
      let startIndex = __startIndex(of: element, in: range),
      let endIndex = __endIndex(of: element, in: range)
    else {
      return nil
    }
    return startIndex..<endIndex
  }
  
  private func __startIndex(
    of element: Element,
    in range: Range<Index>
  ) -> Index? {
    var lowerIndex = range.lowerBound
    var upperIndex = range.upperBound
    while lowerIndex < upperIndex {
      let distance = distance(from: lowerIndex, to: upperIndex)
      let middleIndex = index(lowerIndex, offsetBy: distance / 2)
      let middleElement = self[middleIndex]
      if element < middleElement {
        upperIndex = middleIndex
      } else if element == middleElement {
        if middleIndex == startIndex {
          return middleIndex
        } else if self[index(before: middleIndex)] != element {
          return middleIndex
        } else {
          upperIndex = middleIndex
        }
      } else {
        lowerIndex = index(after: middleIndex)
      }
    }
    return nil
  }
  
  private func __endIndex(
    of element: Element,
    in range: Range<Index>
  ) -> Index? {
    var lowerIndex = range.lowerBound
    var upperIndex = range.upperBound
    while lowerIndex < upperIndex {
      let distance = distance(from: lowerIndex, to: upperIndex)
      let middleIndex = index(lowerIndex, offsetBy: distance / 2)
      let middleElement = self[middleIndex]
      if element < middleElement {
        upperIndex = middleIndex
      } else if element == middleElement {
        if middleIndex == index(before: endIndex) {
          return endIndex
        } else {
          let indexAfterMiddle = index(after: middleIndex)
          if self[indexAfterMiddle] != element {
            return indexAfterMiddle
          } else {
            lowerIndex = indexAfterMiddle
          }
        }
      } else {
        lowerIndex = index(after: middleIndex)
      }
    }
    return nil
  }
}
