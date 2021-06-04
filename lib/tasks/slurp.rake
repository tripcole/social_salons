namespace :slurp do
  desc "TODO"
  task users: :environment do
    require "csv"

    users_csv_text = File.read(Rails.root.join("lib", "csvs", "sample_users.csv"))
    users_csv = CSV.parse(users_csv_text, :headers => true, :encoding => "ISO-8859-1")
    users_csv.each do |row|
    u = User.new
    u.username = row["username"]
    u.first_name = row["first_name"]
    u.last_name = row["last_name"]
    u.email = row["email"]
    u.password = row["password"]
    u.website = row["email"]
    u.save
    end
    puts "There are now #{User.count} rows in the users table"
  end

  task salons: :environment do
    require "csv"

    salons_csv_text = File.read(Rails.root.join("lib", "csvs", "sample_salons.csv"))
    salons_csv = CSV.parse(salons_csv_text, :headers => true, :encoding => "ISO-8859-1")
    salons_csv.each do |row|
    s = Salon.new
    s.name = row["name"]
    s.description = row["description"]
    s.salon_type = row["salon_type"]
    s.street = row["street"]
    s.city = row["city"]
    s.state = row["state"]
    s.zip_code = row["zip_code"]
    s.address = "#{s.street}, #{s.city}, #{s.state} #{s.zip_code}"
    s.save
    end
    puts "There are now #{Salon.count} rows in the salons table"
  end

  task visits: :environment do
    require "csv"

    visits_csv_text = File.read(Rails.root.join("lib", "csvs", "sample_visits.csv"))
    visits_csv = CSV.parse(visits_csv_text, :headers => true, :encoding => "ISO-8859-1")
    visits_csv.each do |row|
    v = Visit.new
    v.visit_date = row["visit_date"]
    v.user_id = row["user_id"]
    v.salon_id = row["salon_id"]
    v.rating = row["rating"]
    v.image = row["image"]
    v.comment = row["comment"]
    v.save
    end
    puts "There are now #{Visit.count} rows in the visits table"
  end

end
