require 'dawanda'

class TestController < ApplicationController

  def dawanda
    a, b = Dawanda.seller_link_and_name(88335163)
    render text: "#{a} - #{b}"
  end

end
