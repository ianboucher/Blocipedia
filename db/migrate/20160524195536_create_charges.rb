class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :membership, index: true, foreign_key: true
      t.string :transaction_id
      t.float   :amount

      t.timestamps null: false
    end
  end
end
