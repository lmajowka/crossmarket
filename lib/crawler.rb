require 'open-uri'

class Crawler

  def self.crawl(url)
    begin
      Nokogiri::HTML(open(url, 'User-Agent' => 'firefox'))
    rescue OpenURI::HTTPError => e
      return false
    end
  end

end