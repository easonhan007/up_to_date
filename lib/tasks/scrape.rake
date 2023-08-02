require 'open-uri'
namespace :scrape do
	desc "Scrape one url"

  task one: :environment do |t, args|
    setting = CrawlerSetting.find(1)
		setting.scrape()
  end

end
