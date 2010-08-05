text "〒#{address.zipcode}"
text "#{address.state.name}#{address.city}#{address.address1}"
text address.address2 unless address.address2.blank?
text "#{address.lastname}#{address.firstname}様"
text address.phone
