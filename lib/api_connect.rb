module ApiConnect
  class News
    def self.get_article(api_key=nil,article_date=nil)
      article_sources = Source.all
      article_sources.each do |source|
        response = HTTParty.get("https://newsapi.org/v1/articles?source=#{source.name}&sortBy=top&apiKey=#{api_key}")
        if response["articles"].present?
          articles = response["articles"].inject([]){ |arry, _hash| arry << { title: _hash["title"], description: _hash["description"], category_id: source.category_id, remote_image_url: _hash["urlToImage"] } if _hash["publishedAt"].include?(article_date) }
          Post.create(articles) if articles.present?
        end
      end
    end
  end
end
