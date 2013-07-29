Deface::Override.new(:virtual_path  => "spree/checkout/payment/_gateway",
                     :insert_before => "[data-hook='card_number']",
                     :partial          => "spree/credit_card_choices",
                     :name          => "credit_card_choice")
