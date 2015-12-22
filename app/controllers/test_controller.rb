require 'dawanda'

class TestController < ApplicationController

  def get_dawanda_users
    created = 0
    (87000000..87165251).each do |product_id|
      link, name = Dawanda.seller_link_and_name(product_id)
      next if link.nil?
      dawanda_user = DawandaUser.new(url: link, name: name)
      if dawanda_user.save
        created += 1
      end
    end
    render text: "created #{created} dawanda users"
  end

  def fetch_users_data
    DawandaUser.where(location: nil).each do |dw|
      dw.fetch_user_info
    end
  end

end
