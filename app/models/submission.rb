require 'csv'

class Submission < ActiveRecord::Base
  belongs_to :form
  has_many :output_jobs
  #has_one_attached :file
  before_create :generate_uuid, unless: :id
  attribute :content, :jsonb, default: {}
  def generate_uuid
    self.id = SecureRandom.uuid
  end

  def to_s
    self.id + " @ "+self.created_at.to_s(:default)
  end
  def as_csv
    row = self.as_json
    row = row.merge(row['content'])
    row = row.except("content")
    csv_string = CSV.generate do |csv|
      csv << row.keys
      csv << row.values
    end
    csv_string
  end
  def as_html
    output = ""
    output += "ID: "+self.id+"</a><br>\n"
    output += "Submitted: "+self.created_at.to_s(:default)+"<br>\n"
    output +="<table>"
    for key in self.content.keys
      if self.content[key]
        output +="<tr><td><b>"+key+"</b></td><td>"+ self.content[key]+"</td></tr>"
      end
    end
    output +="</table>"
    output
  end

  def as_string
    output = ""
    output += "ID: "+self.id+"\n"
    output += "Submitted: "+self.created_at.to_s(:default)+"\n"

    for key in self.content.keys
      if self.content[key]
        output +=key+": "+ self.content[key]+"\n"
      end
    end
    output
  end

end