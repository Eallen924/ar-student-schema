require_relative '../../db/config'

class Teacher < ActiveRecord::Base
  has_many :students
  
  validates :email,
            :presence => true,
            :uniqueness => true
            # :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i } 

  validates :phone,
            :presence => true,
            :format => { :with => /\(\d{3}\)\s\d{3}-\d{4}/ }


  def name
    first_name + " " + last_name
  end
end
