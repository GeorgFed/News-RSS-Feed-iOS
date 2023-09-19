import SwiftUI

struct NewsResponseDTO: Decodable {
  let articles: [NewsArticleDTO]
  let total: Int
}
