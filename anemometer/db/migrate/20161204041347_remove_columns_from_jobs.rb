class RemoveColumnsFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :updated_at, :datetime
  end
end
