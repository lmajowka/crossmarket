task :scrap_dawanda_users => :environment do
  created = 0
  (87000000..87165251).each do |product_id|
    link, name = Dawanda.seller_link_and_name(product_id)
    next if link.nil?
    dawanda_user = DawandaUser.new(url: link, name: name)
    if dawanda_user.save
      created += 1
    end
  end
end