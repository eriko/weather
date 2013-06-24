class CreateDavis < ActiveRecord::Migration
  def change
    rename_table(:records, :davises)
  end
end
