# --- Users ----
User.create!(first_name: "Esteban",
             last_name:  "Ayala",
             email: "esteban.ayala@empresa.com.mx",
             password: "test1234",
             password_confirmation: "test1234",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
User.create!(first_name: "Usuario",
             last_name:  "LastName",
             email: "test@empresa.com.mx",
             password: "test1234",
             password_confirmation: "test1234",
             admin: false,
             activated: true,
             activated_at: Time.zone.now)

# Regions - https://www.royalcaribbean.com/usa/es/cruise-destinations
destinations = [
  { region: "Caribe y las Bahamas",
    destinations: ["El Caribe", "Las Bahamas", "Cococa y", "Las Bermudas"]
  },
  { region: "Europa",
    destinations: ["Europa", "El Mediterráneo", "Grecia y las islas griegas", "Italia"]
  },
  { region: "Alaska",
    destinations: ["Alaska", "Cruise Tours", "Glaciares de Alaska", "Avistamiento de Ballenas"]
  },
  { region: "Norte América",
    destinations: ["Canadá", "Nueva Inglaterra", "Costa Oeste", "Hawai"]
  },
  { region: "Asia",
    destinations: %w[Asia Tailandia China Japon]
  },
  { region: "Pacífico Sur",
    destinations: ["Cruceros por Pacífico Sur", "Australia", "Nueva Zelanda", "Vanuatu y Fiji"]
  }
]

destinations.each do |hash|
  region = Region.find_or_create_by(name: hash[:region])
  hash[:destinations].each do |destination|
    Destination.find_or_create_by(name: destination, region: region)
  end
end
