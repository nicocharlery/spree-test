class AddUserIdToCreditCards < ActiveRecord::Migration
  def change
    add_column :spree_credit_cards, :user_id, :integer
  end
end
