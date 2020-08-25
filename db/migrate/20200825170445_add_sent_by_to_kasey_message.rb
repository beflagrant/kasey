class AddSentByToKaseyMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :kasey_messages, :sent_by, :string, default: 'Kasey'
  end
end
