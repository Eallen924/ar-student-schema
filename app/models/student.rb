require_relative '../../db/config'

class Student < ActiveRecord::Base
  belongs_to :teacher
  validates :email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :birthday,
            :presence => true
  validate  :age_greater_than_five
  validates :phone,
            :presence => true,
            :format => { :with => /\(\d{3}\)\s\d{3}-\d{4}/ }

  def name
    first_name + " " + last_name
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def age_greater_than_five
    errors.add(:birthday, "can't be a toddler") if age < 5
  end

end

# implement your Student model here
