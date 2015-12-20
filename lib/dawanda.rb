require 'crawler'

class Dawanda < Crawler

  PRODUCT_URL = "http://en.dawanda.com/product/%s"

  def self.seller_link_and_name(product_id)
    doc = product_page(product_id)
    return unless doc
    seller_link = doc.at('.vcard a')
    return unless seller_link
    return seller_link['data-href'], seller_link.text
  end

  private

  def self.product_page(id)
    crawl(PRODUCT_URL % id)
  end

end