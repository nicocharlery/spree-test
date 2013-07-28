module Spree
  CheckoutController.class_eval do
    alias_method :orig_update, :update

    def update
      orig_update
      @order.payments.each do |payment|
        if payment.source_type == 'Spree::CreditCard'
          credit_card = Spree::CreditCard.where(id: payment.source_id).first
          credit_card.user_id= @order.user.id
          credit_card.save
        end
      end
    end
  end
end

