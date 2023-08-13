# == Schema Information
#
# Table name: posts
#
#  id                :integer          not null, primary key
#  title             :string
#  content           :text
#  from              :string
#  crawler_record_id :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Post < ApplicationRecord
  belongs_to :crawler_record
  belongs_to :crawler_setting

  validates :title, :content, :from, presence: true

  scope :by_created, -> {order('created_at DESC')}
  scope :recent, -> {by_created.limit(10)}
end
