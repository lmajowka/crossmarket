require 'crawler'

class Etsy < Crawler

  def initialize(url)
    @name, @about = get_info(url)
  end

  private

  def get_info(url)
    doc = Etsy.crawl(url)
    begin
      name = doc.at('#user-info').text.gsub(/\n|(Follow)|\s/,'')
      about = doc.at('#bio').text.gsub(/\n/,'')
    rescue
      return nil, nil
    end
    return name, about
  end

end