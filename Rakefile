require 'rake'
require 'rspec/core/rake_task'
require 'forgery'
require_relative 'db/config'
require_relative 'lib/students_importer'
require_relative 'app/models/teacher'


desc "create the database"
task "db:create" do
  touch 'db/ar-students.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-students.sqlite3'
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc "populate the test database with sample data"
task "db:populate" do
  StudentsImporter.import
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

# desc "Create the teachers"
# task "db:pop_teachers" do
#   teacher_1 = Teacher.create!({first_name: 'Jody',last_name:'Foster', address: '123 Sesame St.', email: 'jody@foster.com', phone: '(555) 555-5555'})
#   teacher_2 = Teacher.create!({first_name:'Brody',last_name: 'Foster', address: '123 Sesame St.', email: 'brody@foster.com',phone: '(555) 555-5555'})
#   teacher_3 = Teacher.create!({first_name:'Cody', last_name: 'Foster', address: '123 Sesame St.', email: 'cody@foster.com', phone:'(555) 555-5555'})
#   teacher_4 = Teacher.create!({first_name:'Jordy',last_name: 'Foster', address: '123 Sesame St.', email: 'jordy@foster.com',phone: '(555) 555-5555'})
#   teacher_5 = Teacher.create!({first_name:'GRody',last_name: 'Foster', address: '123 Sesame St.', email: 'grody@foster.com',phone: '(555) 555-5555'})
#   teacher_6 = Teacher.create!({first_name:'HOody',last_name: 'Foster', address: '123 Sesame St.', email: 'hoody@foster.com',phone: '(555) 555-5555'})
#   teacher_7 = Teacher.create!({first_name:'FOody',last_name: 'Foster', address: '123 Sesame St.', email: 'foody@foster.com',phone: '(555) 555-5555'})
#   teacher_8 = Teacher.create!({first_name:'Woody',last_name: 'Foster', address: '123 Sesame St.', email: 'woody@foster.com',phone: '(555) 555-5555'})
#   teacher_9 = Teacher.create!({first_name:'Lodie',last_name: 'Foster', address: '123 Sesame St.', email: 'lodie@foster.com',phone: '(555) 555-5555'})
# end

desc "Fill database with sample teacher data"
task "db:teachers:populate" do
  10.times do |n|
    first_name = Forgery(:Name).first_name
    last_name  = Forgery(:Name).last_name
    email      = Forgery(:Internet).email_address
    address    = Forgery(:Address).street_address
    phone      = "(555) 555-555#{n}"
    teacher    = Teacher.create!(first_name:    first_name, 
                                  last_name:    last_name, 
                                  email:   email, 
                                  address: address,
                                  phone:   phone)
    10.times do |n|
      first_name = Forgery(:name).first_name
      last_name  = Forgery(:name).last_name
      gender     = ["Male","Female"].sample
      email      = Forgery(:internet).email_address
      phone      = "(555) 555-5555"
      birthday   = Time.now - rand(100000..10000000)
      student = Student.create!(first_name: first_name,
                                last_name:  last_name,
                                email:      email,
                                gender:     gender,
                                phone:      phone,
                                birthday:   birthday)
      student.teacher = teacher
      student.save
    end
  end
end

task :default  => :specs
