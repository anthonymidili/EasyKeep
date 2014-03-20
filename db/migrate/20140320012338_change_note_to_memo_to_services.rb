class ChangeNoteToMemoToServices < ActiveRecord::Migration
  def change
    rename_column :services, :note, :memo
  end
end
