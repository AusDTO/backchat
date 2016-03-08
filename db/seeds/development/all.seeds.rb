User.delete_all

User.create!([
                 {id: 1, email: "admin@example.com", password: 'password',
                  password_confirmation: 'password', admin: true},
                 {id: 2,email: "user@example.com", password: 'password',
                  password_confirmation: 'password', admin: false}
])
#SELECT setval('users_id_seq',3);
ActiveRecord::Base.connection.execute("SELECT setval('users_id_seq', 3);")
Form.delete_all
f = Form.new(name: "My Form", website: "website.com", owner_id:2, input_fields: '[{"name": "site_or_page"}, {"name": "feeling"}, {"name": "feedback"}, {"name": "referrer"}, {"name": "fp"}]')
f.save
Output.delete_all
o = Output.new(name: "SlackTest",type: "SlackOutput",configuration: '{"webhook_url":"http://localhost"}', owner_id:2, form_ids: [f.id])
o.save
Submission.delete_all
s = Submission.new(content: '{"a":"a"}',form_id: f.id)
s.save
OutputJob.delete_all
oj = OutputJob.new(output_id: o.id, submission_id: s.id)
oj.save