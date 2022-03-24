# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Theme.delete_all
Theme.reset_pk_sequence
Theme.create([
               {name: "Какой песик был красивее всех?"}, #1
               {name: "Щенок или взрослый песик?"}, #2
               {name: "Кто симпатичнее пемброк или кардиган?"}, #3
             ])

Human.delete_all
Human.reset_pk_sequence
Human.create([
              {name: "Hoshi", email:"hoshi@pica.com",
               password: "1234", password_confirmation: "1234"},
            ])

Picture.delete_all
Picture.reset_pk_sequence
Picture.create([
                 {name: 'Корги на зеленом фоне', file: 'corgi1.jpg', theme_id:1},
                 {name: 'Корги', file: 'corgi2.jpg', theme_id:2},
                 {name: 'Корги в парке', file: 'corgi3.jpg', theme_id:3},
                 {name: 'Щенок корги', file: 'corgi4.jpg', theme_id:4},
                 {name: 'Корги просто мило лежит', file: 'corgi5.jpg', theme_id:5},
                 {name: 'Корги пират', file: 'corgi6.jpg', theme_id:6},
                 {name: 'Корги дома', file: 'corgi7.jpg', theme_id:7},
                 {name: 'Гуляющий щенок корги', file: 'corgi8.jpg', theme_id:8},
                 {name: 'Корги хочет кушать', file: 'corgi9.jpg', theme_id:9},
                 {name: 'Корги хочет играть', file: 'corgi10.jpg', theme_id:10},
                 {name: 'Корги в траве', file: 'corgi11.jpg', theme_id:11},
                 {name: 'Ушная азбука морзе', file: 'corgi12.jpg', theme_id:12},
               ])
