User.delete_all

User.create!([
                 {id: 1, email: "admin@example.com", password: 'password',
                  password_confirmation: 'password', admin: true},
                 {id: 2,email: "user@example.com", password: 'password',
                  password_confirmation: 'password', admin: false}
])
#SELECT setval('users_id_seq',3);
Form.delete_all
f = Form.new(name: "My Form", website: "website.com", owner_id:2)
f.save
Output.delete_all
o = Output.new(name: "GmailTest",type: "GmailOutput",configuration: '{"a":"a"}', owner_id:2, form_id: f.id)
o.save
Submission.delete_all
s = Submission.new(content: '{"a":"a"}',form_id: f.id)
s.save
OutputJob.delete_all
oj = OutputJob.new(output_id: o.id, submission_id: s.id)
oj.save