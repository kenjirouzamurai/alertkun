# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
company = Company.create!(name: "リベルティ", plan: :pro)

user = User.create!(
  email: "kyamada@rivelty.jp",
  password: "hogehoge",
  company: company,
  line_id: "Ube7f939273b87bf16333aa3d0767ae8d"
)

user.sites.create(name: "ホームページ", domain: "https://rivelty.jp")
