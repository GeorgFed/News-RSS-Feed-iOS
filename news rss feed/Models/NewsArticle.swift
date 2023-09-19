import SwiftUI

struct NewsArticle: Identifiable, Equatable {
  let id = UUID()
  let creator: String
  let title: String
  let contentSnippet: String
  let link: String
  let page: Int
  let index: Int
}
