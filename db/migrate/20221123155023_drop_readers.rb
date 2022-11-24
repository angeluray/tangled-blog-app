class DropReaders < ActiveRecord::Migration[7.0]
  def change
    drop_table :readers
  end
end
