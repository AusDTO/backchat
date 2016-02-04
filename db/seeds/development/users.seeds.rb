User.delete_all

User.create!([
                 {email: "admin@example.com", password: 'password', 
                  password_confirmation: 'password', admin: true},
                 {email: "user@example.com", password: 'password', 
                  password_confirmation: 'password', admin: false}
])
