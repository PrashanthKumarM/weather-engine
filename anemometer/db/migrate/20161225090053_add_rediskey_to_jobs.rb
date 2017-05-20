class AddRediskeyToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :rediskey, :string
  end
end
