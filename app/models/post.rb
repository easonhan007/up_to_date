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

  def manipulate_field(field, openai_key, openapi_base_url, prompt)
    base_url = openapi_base_url ? openapi_base_url : "https://api.openai.com/v1/"
    client = OpenAI::Client.new(
      access_token: openai_key,
      uri_base: base_url,
    )
    response = client.chat(
      parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [{ role: "user", content: prompt + self[field.to_sym]}], # Required.
          temperature: 0.7,
    }) 
    response.dig("choices", 0, "message", "content") rescue ''
  end

  def rewrite_title(openai_key, openapi_base_url, prompt)
    new_title = manipulate_field('title', openai_key, openapi_base_url, prompt)
    if not new_title.blank?
      self[:title] = new_title
      save()
    end
  end

end
