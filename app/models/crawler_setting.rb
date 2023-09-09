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
#  category_id              :integer          default(1), not null
#
class CrawlerSetting < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :crawler_records
  has_many :posts

  validates :name, :index_page_url, :index_page_css, :detail_page_title_css, :detail_page_content_css, presence: true

  def scrape
		uri = URI.parse(index_page_url.strip)
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
						Rails.logger.info(url)
						res = URI.parse(url.to_s) rescue false
						if res
							if res.host
								url = url
							else
								url = "#{domain}/#{url}"
							end
						else
							next
						end #if
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
        # body = post_doc.at_css(detail_page_content_css.strip).inner_html rescue ''
				body_arr = []
				post_doc.css(detail_page_content_css.strip).each do |dom|
					body_arr.push(dom.inner_html)
				end
				# if (not title.blank?) and (not body.blank?)
				if (not title.blank?) and (not body_arr.size.eql?(0))
	        post[:title] = title.strip()
	        post[:url] = url
	        post[:content] = body_arr.join("\n")
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
				Rails.logger.info("Creating #{post[:title]}")
				Post.create(title: post[:title], content: post[:content], from: post[:url], crawler_record_id: r.id, crawler_setting_id: id)
			else
				# update the post
				Rails.logger.info("Updating #{post[:title]}")
				post = Post.where(title: post[:title]).first
				post.content = post[:content]
				post.save()
			end
		end #each
  end

end
