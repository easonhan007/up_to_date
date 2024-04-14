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
#  category_id              :integer          default(1)
#  image_keyword            :string
#
class CrawlerSetting < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :crawler_records, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :name, :index_page_url, :index_page_css, :detail_page_title_css, :detail_page_content_css, presence: true

	scope :activated, ->{ where(active: true) }

	def name_with_status
		self[:active] ? self[:name] : "⚒️ #{self[:name]}"
	end


end
