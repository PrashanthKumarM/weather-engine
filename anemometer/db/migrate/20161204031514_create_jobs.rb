class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :userid
      t.string :station
      t.datetime :submissiontime

      t.timestamps null: false
    end
  end
end
