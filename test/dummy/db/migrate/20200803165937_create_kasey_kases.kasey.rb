# This migration comes from kasey (originally 20200731194421)
class CreateKaseyKases < ActiveRecord::Migration[6.0]
  def change
    create_table :kasey_kases do |t|
      t.references :intake
      t.string :aasm_state
      t.string :token, null:false

      t.timestamps
    end
  end
end
