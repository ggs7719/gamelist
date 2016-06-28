namespace :dev do

  task :rebuild => ["db:drop", "db:setup", :fake]
  # db:setup == db:create, db:schema:load, db;seed

  task :fake => :environment do
    User.delete_all
    Event.delete_all
    Attendee.delete_all
    
    puts "Creating fake data!"

    user = User.create!( :email => "ggs7719@gmail.com", :password => "candy0925")

    100.times do |i|
      e = Event.create( :name => Faker::App.name )
      100.times do |j|
      	e.attendees.create( :name => Faker::Name.name )
      end
    end
 
  end
end