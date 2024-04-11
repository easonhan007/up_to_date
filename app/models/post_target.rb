# == Schema Information
#
# Table name: post_targets
#
#  id            :integer          not null, primary key
#  api           :string
#  key           :string
#  headers       :text             default("{\"Content-Type\": \"application/json\"}")
#  field_mapping :text
#  success_code  :integer          default(200)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string
#  query         :string
#
class PostTarget < ApplicationRecord

  validates :name, :api, :field_mapping, presence: true
  validate :field_mapping_should_be_valid_json

  def field_mapping_should_be_valid_json
    res = JSON.parse(field_mapping) rescue nil
    unless res
      errors.add(:field_mapping, "Field mapping is not a valid JSON string")
    end #unless
  end

end
