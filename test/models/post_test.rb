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
require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
