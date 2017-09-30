# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#Generating predefined categories to feed in categories table
api_key = '8588c5416edc42a7bac605778c70df48'
response = HTTParty.get("https://newsapi.org/v1/sources?sortBy=top&apiKey=#{api_key}")
if response.present?
  categories = response["sources"].map { |_hash| _hash["category"] }.uniq
  categories = categories.inject([]){ |arry, value| arry << { name: value } }

  p "*************** Generating Categories ***************"

  Category.destroy_all
  Category.create(categories)

  p "*************** #{Category.count} categories generated *******************"

  category_hash = Category.pluck(:name, :id).to_h #make a hash of category name as hash key and id as value to avoid muliple call to category call
  category_sources = response["sources"].inject([]){ |arry, value| arry << { name: value["id"], category_id: category_hash[value["category"]] } }

  p "*************** Generating Categories Sources ***************"

  Source.destroy_all #delete any existing record
  Source.create(categories)

  p "*************** #{Source.count} category sources generated *******************"
end


post_sources = Source.all
posts = []
post_sources.each do |source|

  response = HTTParty.get("https://newsapi.org/v1/articles?source=#{source.name}&sortBy=top&apiKey=#{api_key}")
  if response["articles"].present?
    posts = response["articles"].inject([]){ |arry, _hash| arry << { title: _hash["title"], description: _hash["description"], category_id: source.category_id, remote_image_url: _hash["urlToImage"] } }
    Post.create(posts)
  end
end
