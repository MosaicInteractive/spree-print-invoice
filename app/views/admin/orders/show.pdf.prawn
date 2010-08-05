require 'prawn/layout'

bill_address = @order.bill_address
ship_address = @order.ship_address

font_family = Spree::PrintInvoice::Config[:print_invoice_font_family]

font font_family

image Spree::PrintInvoice::Config[:print_invoice_logo_path], :at => [0,720], :fit => [150, 70]

fill_color "005D99"
text t(:customer_invoice, :scope => :print_invoice), :align => :center, :style => :bold, :size => 22
fill_color "000000"

move_down 55

font font_family, :style => :bold, :size => 14
text "#{t :order_number, :scope => :print_invoice}: #{@order.number}"

font font_family, :size => 8
text l(@order.created_at, :format => :long)

# Address Stuff
bounding_box [0,600], :width => 540 do
  move_down 2
  data = [[Prawn::Table::Cell.new( :text => t(:billing_address), :font_style => :bold ),
                Prawn::Table::Cell.new( :text =>t(:shipping_address), :font_style => :bold )]]

  table data,
    :position           => :center,
    :border_width => 0.5,
    :vertical_padding   => 2,
    :horizontal_padding => 6,
    :font_size => 9,
    :border_style => :underline_header,
    :column_widths => { 0 => 270, 1 => 270 }

  move_down 2
  horizontal_rule

  move_down 2

  left_box = bounding_box [6, 0], :width => 258 do
    render :partial=>'/admin/orders/address', :locals => {:address => bill_address}
    move_down 2
  end

  bounding_box [276, left_box.height], :width => 258 do
    render :partial=>'/admin/orders/address', :locals => {:address => ship_address}
    move_down 2
  end

  stroke do
    line_width 0.5
    line bounds.top_left, bounds.top_right
    line bounds.top_left, bounds.bottom_left
    line bounds.top_right, bounds.bottom_right
    line bounds.bottom_left, bounds.bottom_right
  end

end

move_down 30

# Line Items
bounding_box [0,cursor], :width => 540, :height => cursor - 34 do
  move_down 2
  data =  [[Prawn::Table::Cell.new( :text => t(:sku), :font_style => :bold),
                Prawn::Table::Cell.new( :text => t(:item_description), :font_style => :bold ),
               Prawn::Table::Cell.new( :text => t(:unit_price, :default => t(:price)), :font_style => :bold ),
               Prawn::Table::Cell.new( :text => t(:qty), :font_style => :bold, :align => 1 ),
               Prawn::Table::Cell.new( :text => t(:line_total, :default => t(:total)), :font_style => :bold )]]

  table data,
    :position           => :center,
    :border_width => 0,
    :vertical_padding   => 2,
    :horizontal_padding => 6,
    :font_size => 9,
    :column_widths => { 0 => 75, 1 => 290, 2 => 75, 3 => 50, 4 => 50 } ,
    :align => { 0 => :left, 1 => :left, 2 => :right, 3 => :right, 4 => :right }

  move_down 4
  horizontal_rule
  move_down 2

  bounding_box [0,cursor], :width => 540 do
    move_down 2
    data2 = []
    @order.line_items.each do |item|
      data2 << [item.variant.product.sku,
                item.variant.product.name,
                number_to_currency(item.price),
                item.quantity,
                number_to_currency(item.price * item.quantity)]
    end


    table data2,
      :position           => :center,
      :border_width => 0,
      :vertical_padding   => 5,
      :horizontal_padding => 6,
      :font_size => 9,
      :column_widths => { 0 => 75, 1 => 290, 2 => 75, 3 => 50, 4 => 50 },
      :align => { 0 => :left, 1 => :left, 2 => :right, 3 => :right, 4 => :right }
  end

  font font_family, :size => 9

  totals = []

  totals << [Prawn::Table::Cell.new( :text => "#{t :subtotal}:", :font_style => :bold), number_to_currency(@order.item_total)]

  @order.charges.each do |charge|
    totals << [Prawn::Table::Cell.new( :text => charge.description + ":", :font_style => :bold), number_to_currency(charge.amount)]
  end
  @order.credits.each do |credit|
    totals << [Prawn::Table::Cell.new( :text => credit.description + ":", :font_style => :bold), number_to_currency(credit.amount)]
  end

  totals << [Prawn::Table::Cell.new( :text => "#{t :order_total}:", :font_style => :bold), number_to_currency(@order.total)]

  bounding_box [bounds.right - 500, bounds.bottom + (totals.length * 15)], :width => 500 do
    table totals,
      :position => :right,
      :border_width => 0,
      :vertical_padding   => 2,
      :horizontal_padding => 6,
      :font_size => 9,
      :column_widths => { 0 => 425, 1 => 75 } ,
      :align => { 0 => :right, 1 => :right }

  end

  move_down 2

  stroke do
    line_width 0.5
    line bounds.top_left, bounds.top_right
    line bounds.top_left, bounds.bottom_left
    line bounds.top_right, bounds.bottom_right
    line bounds.bottom_left, bounds.bottom_right
  end

end

# Footer
repeat :all do
  text_box t(:footer_message, :scope => :print_invoice), :at => [margin_box.left, margin_box.bottom + 30], :size => 8
end
