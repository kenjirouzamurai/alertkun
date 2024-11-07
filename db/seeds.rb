# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
company = Company.create!(name: "リベルティ", plan: :pro)
company_1 = Company.create!(name: "株式会社ポップコーン", plan: :pro)

user = User.create!(
  email: "kyamada@rivelty.jp",
  password: "hogehoge",
  company: company,
  line_id: "Uc27650c7228e0cbf772ee45a4c3054b1"
)

# user.sites.create(name: "ホームページ", domain: "https://rivelty.jp")

osawa = User.create!(
  email: "yohei.osawa@gmail.com",
  password: "password",
  company: company_1
)
# osawa.sites.create(name: "life", domain: "https://womanlife.online")
