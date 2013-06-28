class CreateDavis < ActiveRecord::Migration
  def change
    rename_table(:weathers, :davises)
  end
end
