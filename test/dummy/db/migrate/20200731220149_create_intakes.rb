class CreateIntakes < ActiveRecord::Migration[6.0]
  def change
    create_table :intakes do |t|
      t.string :email

      t.timestamps
    end
  end
end
