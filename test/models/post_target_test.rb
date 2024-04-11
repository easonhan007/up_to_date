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
require "test_helper"

class PostTargetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
