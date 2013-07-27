require 'spec_helper'

describe  do
  let(:order) { FactoryGirl.create(:order_with_totals) }
  let(:token) { 'some_token' }
  let(:user) { stub_model(Spree::LegacyUser) }

  before do
    Spree::CheckoutController.stub :try_spree_current_user => user
    Spree::CheckoutController.stub :current_order => order
  end

  context "#update" do
    it "should remove completed order from the session" do
      spree_post :update, {:state => "confirm"}, {:order_id => "foofah"}
      session[:order_id].should be_nil
    end
  end

end
