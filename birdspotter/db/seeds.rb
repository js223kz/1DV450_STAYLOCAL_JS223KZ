# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

user1 = User.create(username: "info@webbteknik.se", password: "hejsanhoppsan", password_confirmation: "hejsanhoppsan")
user2 = User.create(username: "info@aspnet.com", password: "jättetråkigt", password_confirmation: "jättetråkigt")
user3= User.create(username: "js@phpfan.se", password: "loveit", password_confirmation: "loveit", admin:true)

user1.apikeys << Apikey.create(application_name: "minfantastiskaapp")
user2.apikeys << Apikey.create(application_name: "minmindrefantastiskaapp")
user3.apikeys << Apikey.create(application_name: "superappen")