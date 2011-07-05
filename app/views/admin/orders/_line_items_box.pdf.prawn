if @hide_prices
  @column_widths = { 0 => 100, 1 => 165, 2 => 75 } 
  @align = { 0 => :left, 1 => :left, 2 => :right }
else
  @column_widths = { 0 => 75, 1 => 265, 2 => 75, 3 => 50, 4 => 75 } 
  @align = { 0 => :left, 1 => :left, 2 => :right, 3 => :right, 4 => :right }
end

# Line Items
bounding_box [0,cursor], :width => 540, :height => 430 do
  move_down 2
  header =  [make_cell( :content => t(:sku), :font_style => :bold),
                make_cell( :content => t(:item_description), :font_style => :bold ) ]
  header <<  make_cell( :content => t(:price), :font_style => :bold ) unless @hide_prices
  header <<  make_cell( :content => t(:qty), :font_style => :bold, :align => 1 )
  header <<  make_cell( :content => t(:total), :font_style => :bold ) unless @hide_prices
    
  table [header],
    :cell_style => {:align => :left,:border_width => 0.0 , :font_style => :bold , :padding => [2  , 5]} ,
    :column_widths => @column_widths do
      columns(2..-1).align = :right
    end

  move_down 4

  bounding_box [0,cursor], :width => 540 do
    move_down 2
    content = []
    @order.line_items.each do |item|
      row = [ item.variant.product.sku, item.variant.product.name ]
      row << number_to_currency(item.price) unless @hide_prices
      row << item.quantity
      row << number_to_currency(item.price * item.quantity) unless @hide_prices
      content << row
    end


    table content,
      :cell_style => {:align => :left,:border_width => 0.0,:size => 9 , :padding => [2  , 5]} ,
      :column_widths => @column_widths do
        columns(2..-1).align = :right
      end
  end

  font "Helvetica", :size => 9

  #bounding_box [20,cursor  ], :width => 400 do
    render :partial => "totals" unless @hide_prices
  #end

  move_down 2

  stroke do
    line_width 0.5
    line bounds.top_left, bounds.top_right
    line bounds.top_left, bounds.bottom_left
    line bounds.top_right, bounds.bottom_right
    line bounds.bottom_left, bounds.bottom_right
  end

end
