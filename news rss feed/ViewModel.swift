import SwiftUI

class NewsViewModel: ObservableObject {
  @Published var articles: [NewsArticle] = []
  @Published var viewedArticleCount: Int = 0
  @Published var currentPage: Int = 1
  @Published var totalPages: Int = 0
  var loadedPages: [Int: [NewsArticle]] = [:]
  let pageSize: Int = 20
  let threshold: Double = 0.7

  init() {
    fetchArticles()
  }

  func fetchArticles() {
    guard let url = URL(string: "http://localhost:3000/news?page=\(currentPage)&pageSize=\(pageSize)") else { return }

    URLSession.shared.dataTask(with: url) { data, _, error in
      if let data = data {
        do {
          let response = try JSONDecoder().decode(NewsResponseDTO.self, from: data)
          DispatchQueue.main.async {
            let articlesToAdd = response.articles.enumerated().map { (index, element) in
              element.toEntity(page: self.currentPage, index: index % self.pageSize + self.currentPage * self.pageSize)
            }
            self.loadedPages[self.currentPage] = articlesToAdd
            self.articles.append(contentsOf: articlesToAdd)
            self.totalPages = response.total
          }
        } catch {
          print("Error decoding articles: \(error)")
        }
      }
    }.resume()
  }

  func loadMore() {
    currentPage += 1
    fetchArticles()
  }

  func articleViewed(index: Int) {
    viewedArticleCount += 1
    if Double(viewedArticleCount) / Double(articles.count) >= threshold {
      loadMore()
    }
  }
}
