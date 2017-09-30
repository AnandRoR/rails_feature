require 'api_connect'
namespace :news_feed do
  desc "update database with lastest feed every day"
  task :feed_data_every_day => :environment do
    api_key = '8588c5416edc42a7bac605778c70df48'
    current_date = DateTime.now.utc.strftime("%Y-%m-%d")
    ApiConnect::News.get_article(api_key, current_date)
  end
end
