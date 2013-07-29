require 'spec_helper'

describe Spree::CheckoutController do
  let(:token) { 'some_token' }
  let(:user) { mock_model(Spree::User, :spree_api_key => 'fake', :last_incomplete_spree_order => nil) }
  let(:order) { create :order }

  before do
    create(:line_item, :order => order)
    controller.stub :try_spree_current_user => user
    controller.stub :current_order => order
  end

  context "#update" do
    before do
      order.stub :confirmation_required? => true
      order.update_column(:state, "confirm")
      order.stub :user => user
      order.stub :available_shipping_methods => [stub_model(Spree::ShippingMethod)]
      order.stub :available_payment_methods => [stub_model(Spree::PaymentMethod)]
      create(:payment, :amount => order.total, :order => order)
      order.payments.reload
    end

    it "should keeps original behaviour" do
      spree_post :update, {:state => "confirm"}, {:order_id => order.id}
      session[:order_id].should be_nil
    end

    it "should associate the credit card to the user" do
      spree_post :update, {:state => "confirm"}, {:order_id => order.id}
      payment = order.payments.first
      credit_card = Spree::CreditCard.where(id: payment.source_id).first
      expect(credit_card.user_id).to eq user.id
    end

    context "when a returning user" do
      it "should add each users credit card as a payment method" do
        expected_user_credit_card = create(:credit_card, user_id: user.id)
        spree_get :edit, { :state => 'payment' }, { :access_token => token }

        returned_user_credit_card = assigns(:user_credit_cards).first
        expect(returned_user_credit_card.last_digits).to eq expected_user_credit_card.last_digits
      end
    end
  end
end
