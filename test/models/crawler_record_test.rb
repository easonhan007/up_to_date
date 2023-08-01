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
require "test_helper"

class CrawlerRecordTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
