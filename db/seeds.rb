# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

company_size = CompanySize.create([
  { code: "1", description: "NÃO INFORMADO" },
  { code: "2", description: "MICRO EMPRESA" },
  { code: "3", description: "EMPRESA DE PEQUENO PORTE" },
  { code: "5", description: "DEMAIS" }
])

partner_type = PartnerType.create([
  { code: "1", description: "PESSOA JURÍDICA" },
  { code: "2", description: "PESSOA FÍSICA" },
  { code: "3", description: "ESTRANGEIRO" }
])

age_group = AgeGroup.create([
  { code: "1", description: "Entre 0 a 12 anos" },
  { code: "2", description: "Entre 13 a 20 anos" },
  { code: "3", description: "Entre 21 a 30 anos" },
  { code: "4", description: "Entre 31 a 40 anos" },
  { code: "5", description: "Entre 41 a 50 anos" },
  { code: "6", description: "Entre 51 a 60 anos" },
  { code: "7", description: "Entre 61 a 70 anos" },
  { code: "8", description: "Entre 71 a 80 anos" },
  { code: "9", description: "Maiores de 80 anos" },
  { code: "0", description: "Não se aplica" }
])

registration_situation = RegistrationSituation.create([
  { code: "1", description: "NULA" },
  { code: "2", description: "ATIVA" },
  { code: "3", description: "SUSPENSA" },
  { code: "4", description: "INAPTA" },
  { code: "8", description: "BAIXADA" }
])