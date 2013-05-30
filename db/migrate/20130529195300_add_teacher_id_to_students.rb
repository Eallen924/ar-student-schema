require_relative '../config'

# this is where you should use an ActiveRecord migration to 

class AddTeacherIdToStudents < ActiveRecord::Migration
  def up
    add_column :students, :teacher_id, :integer     
  end

  def down
    remove_column :students, :teacher_id 
  end
end
