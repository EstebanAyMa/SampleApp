# --- Users ----
if User.find_by(email: "esteban.ayala@empresa.com.mx").nil?
  User.create!(first_name: "Esteban",
               last_name:  "Ayala",
               email: "esteban.ayala@empresa.com.mx",
               password: "test1234",
               password_confirmation: "test1234",
               admin: true,
               activated: true,
               activated_at: "2022-11-07")
end

# Regions - https://www.royalcaribbean.com/usa/es/cruise-destinations
destinations = [
  { region: "Caribe y las Bahamas",
    destinations: ["El Caribe", "Las Bahamas", "Cococay", "Las Bermudas"]
  },
  { region: "Europa",
    destinations: ["Europa", "El Mediterraneo", "Grecia y las islas griegas", "Italia"]
  },
  { region: "Alaska",
    destinations: ["Alaska", "Cruise Tours", "Glaciares de Alaska", "Avistamiento de Ballenas"]
  },
  { region: "Norte America",
    destinations: ["Canada", "Nueva Inglaterra", "Costa Oeste", "Hawai"]
  },
  { region: "Asia",
    destinations: %w[Asia Tailandia China Japon]
  },
  { region: "Pacifico Sur",
    destinations: ["Cruceros por Pacifico Sur", "Australia", "Nueva Zelanda", "Vanuatu y Fiji"]
  }
]

destinations.each do |hash|
  region = Region.find_or_create_by(name: hash[:region])
  hash[:destinations].each do |destination|
    Destination.find_or_create_by(name: destination, region: region)
  end
end
