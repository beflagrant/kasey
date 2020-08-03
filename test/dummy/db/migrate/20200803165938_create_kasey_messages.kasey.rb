# This migration comes from kasey (originally 20200731194836)
class CreateKaseyMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :kasey_messages do |t|
      t.integer 'direction', default: 0
      t.references :kase

      t.timestamps
    end
  end
end
