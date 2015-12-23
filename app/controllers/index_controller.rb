require 'etsy'

SIMILARITY_THRESHOLD = 80

class IndexController < ApplicationController

  def index

    @results = []

    etsy_identities.each do |etsy_identity|
      etsy = Etsy.new etsy_identity
      dawanda_user, similarity = get_dawanda_user_for etsy

      if dawanda_user
        @results << {
            etsy: etsy_identity,
            dawanda_user: dawanda_user,
            similarity: similarity
        }
      end

    end

  end

  def get_dawanda_user_for(etsy)

    [:name, :about].each do |esty_attribute|
      dw_results = DawandaUser.search etsy.send(esty_attribute)
      dw_results.each do |dw|
        similarity = dw.attribute_similarity esty_attribute, etsy.send(esty_attribute)
        if similarity > SIMILARITY_THRESHOLD
          return dw, similarity
        end
      end
    end

    return nil, nil
  end

  def etsy_identities
    [
        'https://www.etsy.com/people/RowanberryGlass',
        'https://www.etsy.com/people/ArtisticEdition',
        'https://www.etsy.com/people/elcofredelena',
        'https://www.etsy.com/people/hertadesign',
        'https://www.etsy.com/people/Herzisstoffwelt',
        'https://www.etsy.com/people/fashionfrill',
        'https://www.etsy.com/people/doloopleather'
    ]
  end

end
