# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Category.create([{ name: 'Books' }, { name: 'Signs' }, { name: 'Silverware' }, { name: 'Coins' }, { name: 'Other' }])
admin_user = { email: 'abidmahamood88@gmail.com', password: '123456', role: :admin }

user = User.find_or_initialize_by(email: admin_user[:email])
user.update!(admin_user)

puts 'Admin user has been created'