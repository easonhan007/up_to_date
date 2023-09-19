# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  weight     :integer          default(0)
#
class Category < ApplicationRecord
  belongs_to :user
  has_many :crawler_settings, dependent: :nullify

  validates :name, :slug, presence: true

  def last_ten_posts
    posts = []
    default_order = 'created_at DESC'
    if crawler_settings.size.eql?(1)
      posts = crawler_settings.first.posts.order(default_order).limit(10)
    else
      length = 0
      crawler_settings.each do |setting|
        setting.posts.order(default_order).each do |record|
          if length < 10
            posts.push(record)
            length += 1
          else
            break
          end #if
        end
      end #each
    end #if
    posts
  end

end
