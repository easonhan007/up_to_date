# == Schema Information
#
# Table name: settings
#
#  id         :integer          not null, primary key
#  name       :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Setting < ApplicationRecord
  validates :name, :value, presence: true

  def self.get(key)
    res = Setting.where(name: key).take()
    if not res.blank?
      res.value.strip()
    else
      ''
    end #If
  end

end
