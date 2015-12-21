require 'dawanda'

class DawandaUser < ActiveRecord::Base

  validates_uniqueness_of :url

  searchkick

  def fetch_user_info
    return unless url
    doc = Dawanda.user_page url
    return unless doc
    location = extract_location_from_user_header(doc.at('#user_header_inner'))
    about = doc.search('.right.main p').text
    update_attributes(
        location: location,
        about: about
    )
  end

  private

  def extract_location_from_user_header(user_header_inner)
    user_header_inner.children[1].children[13].text.gsub(/\n|(Location)|\s/,'')
  end

end
