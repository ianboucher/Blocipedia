class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :ref_no
      t.string :charge_id
      t.float :amount
      t.references :membership, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
