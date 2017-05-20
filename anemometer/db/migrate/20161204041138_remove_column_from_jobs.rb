class RemoveColumnFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :created_at, :datetime
  end
end
