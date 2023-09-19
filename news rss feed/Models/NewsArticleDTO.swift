import SwiftUI

struct NewsArticleDTO: Decodable {
  let creator: String
  let title: String
  let contentSnippet: String
  let link: String

  func toEntity(page: Int, index: Int) -> NewsArticle {
    NewsArticle(creator: creator, title: title, contentSnippet: contentSnippet, link: link, page: page, index: index)
  }
}
