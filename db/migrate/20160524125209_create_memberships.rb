class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user,                 index: true, foreign_key: true
      t.boolean    :active,               null: false, default: false
      t.boolean    :cancel_at_period_end, null: false, default: false
      t.datetime   :active_until
      t.string     :status
      t.string     :subscribe_id

      t.timestamps null: false
    end
  end
end
