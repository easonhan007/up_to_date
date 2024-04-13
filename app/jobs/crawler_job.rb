require 'open-uri'
class CrawlerJob < ApplicationJob
  queue_as :default

  def perform(setting)
		uri = URI.parse(setting.index_page_url.strip)
		# FIXME missing port support
    host = uri.host
		domain = "#{uri.scheme}://#{uri.host}"
    begin
      doc = Nokogiri::HTML(URI.open(setting.index_page_url)) 
    rescue => e
			r = CrawlerRecord.create(crawler_setting_id: setting.id, log: e.message)
      return
    end

    post_urls = []
    posts = []
    error_msgs = []

    begin
      index_links = doc.css(setting.index_page_css) 
    rescue
			r = CrawlerRecord.create(crawler_setting_id: setting.id, log: e.message)
      return 
    end

    index_links.each do |link|
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
				Rails.logger.info("Start to crawler #{url}")
        begin
          post_doc = Nokogiri::HTML5(URI.open(url))
        rescue => e
          error_msgs << {url: url, message: e.message, type: 'Can not open url'}
          next 
        end

        # ensure all the images looks good
        post_doc.css('img').each do |img|
          img['class'] = 'img-fluid'
          img['loading'] = 'lazy'
        end #each

        begin
          title = post_doc.at_css(setting.detail_page_title_css.strip).content
        rescue => e
          error_msgs << {url: url, message: e.message, type: "Can not identify title using #{setting.detail_page_title_css}"}
          next
        end

				unless setting.detail_page_clean_up_css.blank?
					setting.detail_page_clean_up_css.split(',').each do |css|
            begin
              parts = post_doc.css(css.strip)
            rescue => e
              error_msgs << {url: url, message: e.message, type: "Clear #{css} failed"}
              next 
            end

						parts.each do |part|
							part.inner_html = ''
						end #each 
					end #each
				end #unless

				body_arr = []
        begin
          body_parts = post_doc.css(setting.detail_page_content_css.strip)
        rescue => e
          error_msgs << {url: url, message: e.message, type: "Can not identify title using #{setting.detail_page_title_css}"}
          next
        end
				body_parts.each do |dom|
					body_arr.push(dom.inner_html)
				end
				# if (not title.blank?) and (not body.blank?)
				if (not title.blank?) and (not body_arr.size.eql?(0))
	        post[:title] = title.strip()
	        post[:url] = url
	        post[:content] = body_arr.join("\n")
					# post[:image_url] = get_a_rand_image(Rails.configuration.x.image_rand_categories.sample)
					post[:slug] = title.strip().gsub(/[[:punct:]]/, '').squeeze.gsub(' ', '-')
	        posts.push(post)
				end 
      end #each 
			total = post_urls.size
			success = posts.size
			failed = total - success
			urls = JSON.dump(post_urls)
      log = JSON.dump(error_msgs)
			r = CrawlerRecord.create(url_count:total, success: success, failed: failed, urls: urls, crawler_setting_id: setting.id, log: log)
		else
      log = JSON.dump(error_msgs)
			r = CrawlerRecord.create(url_count:0, success: 0, failed: 0,  crawler_setting_id: setting.id, log: log)
		end #unless

    if not setting.image_keyword.blank?
      image_category = setting.image_keyword
    else
      image_category = Rails.configuration.x.image_rand_categories.sample
    end

    images = get_images(image_category, posts.size)
    Rails.logger.info(images)
		posts.each_with_index do |post, index|
      post[:image_url] = images[index]
			unless Post.exists?(title: post[:title])
				Rails.logger.info("Creating #{post[:title]}")
				Post.create(title: post[:title], 
                    content: post[:content], 
                    from: post[:url], 
                    crawler_record_id: r.id, 
                    crawler_setting_id: setting.id,
                    slug: post[:slug],
                    image_url: post[:image_url])
			else
				# update the post
				Rails.logger.info("Updating #{post[:title]} 💻")
				post = Post.where(title: post[:title]).first
				post.content = post[:content]
				post.save()
        post.touch(:updated_at)
			end
		end #each
  end

  def get_images(category="nature", count=20)
    photos = []
		rand_page = rand(20)
		default_img = Rails.configuration.x.default_post_image
		api_key = Setting.get('pexels_api_key')
    # pexels_api_key set as pexels_api_key by seeds.rb
		if api_key.blank? or api_key.eql?('pexels_api_key')
      count.times { |i| photos.push(default_img) }
      return photos
		end
		client = Pexels::Client.new(api_key)
    ret = client.photos.search(category, orientation: :landscape, per_page: count, page: rand_page)
    if ret.blank?
      ret = client.photos.search('nature', orientation: :landscape, per_page: count, page: rand(20))
    end

    ret.photos.each do |photo|
      photos.push(photo.src['landscape'])
    end

    return photos
  end

	def get_a_rand_image(category="nature")
		rand_page = rand(20)
		default_img = Rails.configuration.x.default_post_image
		api_key = Setting.get('pexels_api_key')
		if api_key.blank?
			return default_img
		end

		client = Pexels::Client.new(api_key)

    res = client.photos.search(category, orientation: :landscape, per_page: 20, page: rand_page)
    if res.blank?
      res = client.photos.search('nature', orientation: :landscape, per_page: rand(80), page: rand(20))
    end

    return res.photos.sample.src['landscape']

	end

end
