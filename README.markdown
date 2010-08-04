SUMMARY
=======

This extension provides a "Print Invoice" button on the Admin Orders view screen which generates a PDF of the order details.

 
INSTALLATION
------------

1. Install the prawn_hander plugin

      script/plugin install git://github.com/Roman2K/prawn-handler.git
      
2. Install this extension

      script/extension install git://github.com/BDQ/spree-print-invoice.git

3. Make sure you have the required gems

      sudo gem install prawn --version="0.8.4"
      
4. Optional: Set the logo path preference to include your store / company logo, or the font family preference to use a different font. In your seeds.rb or site extension initializer:

      Spree::PrintInvoice::Config.set(:print_invoice_logo_path => "#{RAILS_ROOT}/public/images/company-logo.png")
      Spree::PrintInvoice::Config.set(:print_invoice_font_family => "Times-Roman")

      Note: The logo is automatically resized. A 600x280 image will print at roughly 300dpi on A4/Letter. Larger images give nicer outputs, but at the expense of a slower rendering.

5. Enjoy!

