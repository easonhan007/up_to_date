# == Schema Information
#
# Table name: crawler_records
#
#  id                 :integer          not null, primary key
#  url_count          :integer
#  success            :integer
#  failed             :integer
#  urls               :text
#  crawler_setting_id :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class CrawlerRecord < ApplicationRecord
  belongs_to :crawler_setting
  has_many :posts

  scope :by_created, ->{order('created_at DESC')}
end
