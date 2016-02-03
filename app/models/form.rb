''' Forms
Have uuid
Have property/website
Have input fields with types including restrictions on uploaded files
Have outputs, email, zendesk, Google sheet
- api authorisation tokens and other configuration/templates
Have thank-you url
Produce stats eg. number responses/average satisfaction per page and total
'''

class Form < ActiveRecord::Base
  has_many :submissions
  has_many :outputs
  belongs_to :user
end