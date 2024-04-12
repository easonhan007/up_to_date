# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


if Rails.env.development?
	user = 'ethanhan@itest.info'
	passwd = '123456'

	unless User.exists?(email: user)
		puts "creating user #{user}"
		User.create!(email: user, password: passwd, password_confirmation: passwd)
	end 

end #if


puts "creating the first setting"
CrawlerSetting.create(name: 'vox', 
	index_page_url: 'https://www.vox.com/', 
	index_page_css: '.c-newspaper__main h2>a',
	detail_page_title_css: '.c-page-title',
	detail_page_content_css: 'div.c-entry-content',
	detail_page_clean_up_css: '.c-article-footer,.c-float-right,.m-ad'
)

puts "creating basic settings"
%w[openai_key openapi_base_url pexels_api_key title_rewrite_prompt].each do |key|
	if not Setting.where(name: key).exists?
		Setting.create(name: key, value: key)
	end #if
end