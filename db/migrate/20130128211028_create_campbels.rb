class CreateCampbels < ActiveRecord::Migration
  def change
    rename_table(:records, :campbels)

    #rename_table(:davises , :inter)
    #rename_table( :campbels,:davises)
    #rename_table(:inter, :campbels)
  end
end
