totals = []

totals << [make_cell( :content => t(:subtotal), :font_style => :bold), number_to_currency(@order.item_total)]

@order.adjustments.each do |charge|
  totals << [make_cell( :content => charge.label + ":", :font_style => :bold), number_to_currency(charge.amount)]
end

totals << [make_cell( :content => t(:order_total), :font_style => :bold), number_to_currency(@order.total)]

bounding_box [bounds.right - 500, bounds.bottom + (totals.length * 18)], :width => 500 do
  table totals,
    :cell_style => {:align => :right,:border_width => 0.0 , :padding => [2,  5]} ,
    :column_widths => { 0 => 425, 1 => 75 }

end
