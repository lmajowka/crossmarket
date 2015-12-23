require 'crawler'

class Etsy < Crawler

  attr_accessor :name, :about, :location

  def initialize(url)
    @name, @about, @location = get_info(url)
  end

  private

  def get_info(url)
    doc = Etsy.crawl(url)
    begin
      name = doc.at('#user-info a').text.gsub(/\n|(Follow)|\s/,'')
      location = nil
      if doc.at('#user-info .location').presence
        location = doc.at('#user-info .location').text.gsub(/\n|\s/,'')
      end
      about = doc.at('#bio').text.gsub(/\n/,'')
    rescue
      return nil, nil, nil
    end
    return name, about, location
  end

end