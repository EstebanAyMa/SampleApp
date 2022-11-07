# --- Users ----
User.create!(first_name: "Esteban",
             last_name:  "Ayala",
             email: "esteban.ayala@empresa.com.mx",
             password:              "test1234",
             password_confirmation: "test1234",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
