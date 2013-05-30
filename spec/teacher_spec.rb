require 'rspec'
require 'date'
require_relative '../app/models/teacher'


describe Teacher, "#name and #age" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Base.connection.table_exists?(:students).should be_true
    Teacher.delete_all

    @teacher = Teacher.new
    @teacher.assign_attributes(
      :first_name  => "Jody",
      :last_name   => "Foster",
      :address     => "123 Sesame St.",
      :email       => "jody@foster.com",
      :phone       => "(555) 555-5555"
    )
  end

  it "should have name method" do
    [:name].each { |mthd| @teacher.should respond_to mthd }
  end

  it "should concatenate first and last name" do
    @teacher.name.should == "Jody Foster"
  end
end
