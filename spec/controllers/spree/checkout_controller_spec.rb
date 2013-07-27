require 'spec_helper'

describe Spree::CheckoutController do
  let(:token) { 'some_token' }
  #let(:user) { stub_model(Spree::LegacyUser) }
  let(:user) { mock_model(Spree::User, :spree_api_key => 'fake', :last_incomplete_spree_order => nil) }
  let(:order) { FactoryGirl.create :order }

  before do
    FactoryGirl.create(:line_item, :order => order)
    controller.stub :try_spree_current_user => user
    controller.stub :current_order => order
  end

  context "#update" do
    it "should remove completed order from the session" do
      spree_post :update, {:state => "confirm"}, {:order_id => "foofah"}
      session[:order_id].should be_nil
    end
  end

end
