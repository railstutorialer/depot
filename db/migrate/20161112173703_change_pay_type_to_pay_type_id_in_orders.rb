class ChangePayTypeToPayTypeIdInOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :pay_type
    add_reference :orders, :pay_type, foreign_key:true
  end
end
