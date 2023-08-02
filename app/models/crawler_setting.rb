# == Schema Information
#
# Table name: crawler_settings
#
#  id                       :integer          not null, primary key
#  name                     :string
#  index_page_url           :string
#  index_page_css           :string
#  detail_page_title_css    :string
#  detail_page_content_css  :string
#  user_id                  :integer          not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  detail_page_clean_up_css :text
#
class CrawlerSetting < ApplicationRecord
  belongs_to :user
  has_many :crawler_records

  validates :name, :index_page_url, :index_page_css, :detail_page_title_css, :detail_page_content_css, presence: true

  def scrape
		uri = URI.parse(index_page_url)
		# FIXME missing port support
    host = uri.host
		domain = "#{uri.scheme}://#{uri.host}"
    doc = Nokogiri::HTML(URI.open(index_page_url))
    post_urls = []
    posts = []
    doc.css(index_page_css).each do |link|
      post_urls.push(link.attribute('href'))
    end

    unless post_urls.blank?
      post_urls.each do |url|
				unless url.to_s.include?(host)
					if url.to_s.start_with?('/')
						url = domain + url.to_s
					else
						next
					end #if
				end

        post = {}
        post_doc = Nokogiri::HTML5(URI.open(url))

				unless detail_page_clean_up_css.blank?
					detail_page_clean_up_css.split(',').each do |css|
						post_doc.css(css.strip).each do |part|
							part.inner_html = ''
						end #each 
					end #each
				end #unless

        # ensure all the images looks good
        post_doc.css('img').each do |img|
          img['class'] = 'img-fluid'
        end #each

        title = post_doc.at_css(detail_page_title_css.strip).content rescue ''
        body = post_doc.at_css(detail_page_content_css.strip).inner_html rescue ''
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
			r = CrawlerRecord.create(url_count:total, success: success, failed: failed, urls: urls, crawler_setting_id: id)
		else
			r = CrawlerRecord.create(url_count:0, success: 0, failed: 0,  crawler_setting_id: id)
		end #unless

		posts.each do |post|
			unless Post.exists?(title: post[:title])
				puts "Creating #{post[:title]}"
				Post.create(title: post[:title], content: post[:content], from: post[:url], crawler_record_id: r.id, crawler_setting_id: id)
			end
		end #each
  end

end
