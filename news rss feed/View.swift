import SwiftUI

struct ContentView: View {
  @StateObject private var newsViewModel = NewsViewModel()

  var body: some View {
    List {
      ForEach(newsViewModel.articles.indices, id: \.self) { index in
        let article = newsViewModel.articles[index]
        VStack(alignment: .leading, spacing: 8) {
          Text(article.creator)
            .font(.caption)
            .foregroundColor(.gray)

          Text(article.title)
            .font(.headline)

          Text(article.contentSnippet.prefix(100) + "...")
            .font(.body)
            .foregroundColor(.secondary)

          Link("Read More", destination: URL(string: article.link)!)
            .font(.body)
            .onAppear {
              if index == newsViewModel.articles.count - 1 {
                newsViewModel.loadMore()
              }
              newsViewModel.articleViewed(index: index)
            }
        }
      }
    }
    .navigationBarTitle("News Articles")
  }
}
