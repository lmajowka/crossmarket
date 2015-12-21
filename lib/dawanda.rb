require 'crawler'

class Dawanda < Crawler

  PRODUCT_URL = "http://en.dawanda.com/product/%s"
  ROOT_URL = "http://en.dawanda.com%s"

  def self.seller_link_and_name(product_id)
    doc = product_page(product_id)
    return unless doc
    seller_link = doc.at('.vcard a')
    return unless seller_link
    return seller_link['data-href'], seller_link.text
  end

  def self.user_page(url)
    crawl(ROOT_URL % url)
  end

  private

  def self.product_page(id)
    crawl(PRODUCT_URL % id)
  end


end