require 'dawanda'

class TestController < ApplicationController

  def get_dawanda_users
    created = 0
    (1..1000).each do |product_id|
      link, name = Dawanda.seller_link_and_name(product_id)
      dawanda_user = DawandaUser.new(url: link, name: name)
      if dawanda_user.save
        created += 1
      end
    end
    render text: "created #{created} dawanda users"
  end

end
