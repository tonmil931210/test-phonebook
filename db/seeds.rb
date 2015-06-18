# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

p User.new(username: 'sa', sa: true, token: '1231221341', password: '12345', password_confirmation: '12345').save
p User.new(username: 'milton', token: '1231221341wwe', password: '12345', password_confirmation: '12345').save
p User.new(username: 'milton_2', password: '12345', password_confirmation: '12345').save