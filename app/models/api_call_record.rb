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
class ApiCallRecord < ApplicationRecord
  attribute :sent_status, :boolean
  belongs_to :user
  belongs_to :post
  belongs_to :post_target

  def sent_status
    status_code.eql?(post_target.success_code) ? '✅' : '❌'
  end

  def call_api()
    api_path = post_target.api
    query = post_target.query
    api = "#{api_path}?#{query}"
    status_code = post_target.success_code
    headers = format_headers
    body = format_body

    resp = send_request(api, headers, body)
    self[:status_code] = resp.code
    self[:log] = resp.body.to_s.encode('UTF-8', invalid: :replace, undef: :replace, replace: '?')
    save
  end

  def format_headers
    header_arr = []

    if post_target.headers.present?
      headers_dict = JSON.parse(post_target.headers)
      headers_dict.each_pair do |k, v|
        header_arr.push({key:k, value: v})
      end #each
    end
    header_arr
  end

  def format_body
    mapping = post_target.field_mapping
    mapping_dict = JSON.parse(mapping)
    # only support 2 levels post data
    mapping_dict.each_pair do |k, v|
      if v.is_a?(Hash)
        v.each_pair do |k1, v1|
          v[k1] = eval(v1)
        end #each
      else
        mapping_dict[k] = eval(v1)
      end #if
    end #each
    return JSON.dump(mapping_dict)
  end

  # create post (POST )
  def send_request(api, headers, data)
    uri = URI(api)

    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    # body = JSON.dump(data)

    # Create Request
    req =  Net::HTTP::Post.new(uri)
    # Add headers
    headers.each do |header|
      req.add_field header[:key], header[:value] 
    end #each

    # Set body
    req.body = data

    # Fetch Request
    res = http.request(req)
    return res
  # rescue StandardError => e
  #   return OpenStruct.new(code: 999, body: e.message)
  end

end
