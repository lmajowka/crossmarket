require 'dawanda'

class DawandaUser < ActiveRecord::Base

  LOCATION_DEFAULT_POSITION = 13

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

  def attribute_similarity(attribute_name, string_to_compare)
    send(attribute_name).similar string_to_compare
  end

  private

  def extract_location_from_user_header(user_header_inner)
    (0..LOCATION_DEFAULT_POSITION).each do |trial_index|
      begin
        text = user_header_inner.children[1].children[LOCATION_DEFAULT_POSITION - trial_index].text
        if text.match(/Location/)
          return text.gsub(/\n|(Location)|\s/,'')
        end
      rescue
      end
    end
  end

end
