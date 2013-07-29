module Spree
  CheckoutController.class_eval do
    alias_method :orig_update, :update

    def update
      orig_update

      if @order.user.present?
        @order.payments.each do |payment|
          if payment.source_type == 'Spree::CreditCard'
            credit_card = CreditCard.where(id: payment.source_id).first
            if credit_card
              credit_card.user_id= @order.user.id
              credit_card.save
            end
          end
        end
      end
    end

    def before_payment
      @user_credit_cards = CreditCard.where(user_id: @order.user.id) if @order.user.present?
      @user_credit_cards ||= []
    end
  end
end

