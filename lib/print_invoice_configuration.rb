class PrintInvoiceConfiguration < Configuration
  preference :print_invoice_font_family, :string, :default => "Helvetica"
  preference :print_invoice_logo_path, :string, :default => "#{RAILS_ROOT}/public/images/admin/bg/spree_50.png"
end