require 'open-uri'
namespace :scrape do
	desc "Scrape one url"

  task one: :environment do
    setting = CrawlerSetting.first
    doc = Nokogiri::HTML(URI.open(setting.index_page_url))
    post_urls = []
    posts = []
    doc.css(setting.index_page_css).each do |link|
      post_urls.push(link.attribute('href'))
    end

    unless post_urls.blank?
      post_urls.each do |url|
        post = {}
        post_doc = Nokogiri::HTML5(URI.open(url))
				unless setting.detail_page_clean_up_css.blank?
					setting.detail_page_clean_up_css.split(',').each do |css|
						post_doc.css(css.strip).each do |part|
							part.inner_html = ''
						end #each 
					end #each
				end #unless
        title = post_doc.at_css(setting.detail_page_title_css.strip).content rescue ''
        body = post_doc.at_css(setting.detail_page_content_css.strip).inner_html rescue ''
				if (not title.blank?) and (not body.blank?)
	        post[:title] = title
	        post[:url] = url
	        post[:content] = body
	        posts.push(post)
				end 
      end #each 
			total = post_urls.size
			success = posts.size
			failed = total - success
			urls = JSON.dump(post_urls)
			r = CrawlerRecord.create(url_count:total, success: success, failed: failed, urls: urls, crawler_setting_id: setting.id)
		else
			r = CrawlerRecord.create(url_count:0, success: 0, failed: 0,  crawler_setting_id: setting.id)
		end #unless

		posts.each do |post|
			unless Post.exists?(title: post[:title])
				puts "Creating #{post[:title]}"
				Post.create(title: post[:title], content: post[:content], from: post[:url], crawler_record_id: r.id)
			end
		end #each

  end

end
