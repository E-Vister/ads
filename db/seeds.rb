User.create!(username:  "Admin",
             email: "example@mail.eu",
             phone: "+375336518471",
             password:              "123123",
             password_confirmation: "123123",
             admin: true)

99.times do |n|
  name  = "User_#{n+1}"
  email = "e-#{n+1}@mail.eu"
  phone = "+123123123#{n+1}"
  password = "password"
  User.create!(username:  name,
               email: email,
               phone: phone,
               password:              password,
               password_confirmation: password)
end