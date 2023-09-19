# == Schema Information
#
# Table name: crawler_settings
#
#  id                       :integer          not null, primary key
#  name                     :string
#  index_page_url           :string
#  index_page_css           :string
#  detail_page_title_css    :string
#  detail_page_content_css  :string
#  user_id                  :integer          not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  detail_page_clean_up_css :text
#  category_id              :integer          default(1)
#
require "test_helper"

class CrawlerSettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
