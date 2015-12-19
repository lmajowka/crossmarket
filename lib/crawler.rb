require 'open-uri'

class Crawler

  def self.crawl(url)
    Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
  end

end