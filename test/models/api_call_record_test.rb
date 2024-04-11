# == Schema Information
#
# Table name: api_call_records
#
#  id             :integer          not null, primary key
#  post_id        :integer
#  post_target_id :integer
#  status_code    :integer
#  log            :text
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class ApiCallRecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
