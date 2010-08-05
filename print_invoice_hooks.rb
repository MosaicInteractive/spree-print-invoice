class PrintInvoiceHooks < Spree::ThemeSupport::HookListener

  insert_after :admin_order_show_buttons do
    %( <%= button_link_to(t(:print_invoice, :scope => :print_invoice), formatted_admin_order_url(@order, :pdf)) %>)
  end

  insert_after :admin_order_edit_buttons do
    %( <%= button_link_to(t(:print_invoice, :scope => :print_invoice), formatted_admin_order_url(@order, :pdf)) %>)
  end

end
