class AddPolymorphicIntakeToKase < ActiveRecord::Migration[6.0]
  def change

    change_table :products do |t|
      t.references :imageable, polymorphic: true
    end
  end
end
