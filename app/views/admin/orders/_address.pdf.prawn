text "#{address.firstname} #{address.lastname}"
text address.address1
text address.address2 unless address.address2.blank?
text "#{address.city}, #{address.state ? address.state.abbr : ''} #{address.zipcode}"
text address.country.name
text address.phone
