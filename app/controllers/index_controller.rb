require 'etsy'

SIMILARITY_THRESHOLD = 80

class IndexController < ApplicationController

  def index

    @results = []

    etsy_identities.each do |etsy_identity|
      etsy = Etsy.new etsy_identity
      dawanda_user = get_dawanda_user_for etsy

      @results << {
          etsy: etsy_identity,
          dawanda_user: dawanda_user
      }
    end

  end

  def get_dawanda_user_for(etsy)

    dw_results = DawandaUser.search etsy.name
    dw_results.each do |dw|
      if dw.name_similarity(etsy.name) > SIMILARITY_THRESHOLD
        return dw
      end
    end

    dw_results = DawandaUser.search etsy.about
    dw_results.each do |dw|
      if dw.name_similarity(etsy.about) > SIMILARITY_THRESHOLD
        return dw
      end
    end

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
