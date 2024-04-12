# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  title              :string
#  content            :text
#  from               :string
#  crawler_record_id  :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  crawler_setting_id :integer          not null
#  slug               :string
#  image_url          :string
#
class Post < ApplicationRecord
  belongs_to :crawler_record
  belongs_to :crawler_setting
  has_many :favorites
  has_many :api_call_records

  validates :title, :content, :from, presence: true

  scope :by_created, -> {order('created_at DESC')}
  scope :recent, -> {by_created.limit(20)}

  def is_favorited_by(user)
    Favorite.exists?(user_id: user.id, post_id: self.id)
  end

  def self.api_fields
    # %w[title content slug image_url]
    %w[title slug image_url]
  end

end
