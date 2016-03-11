class Submission < ActiveRecord::Base
  belongs_to :form
  has_many :output_jobs
  attachment :file
  before_create :generate_uuid, unless: :id

  def generate_uuid
    self.id = SecureRandom.uuid
  end

  def to_s
    self.id + " @ "+self.created_at.to_s(:default)
  end

  def as_html
    output = ""
    output += "ID: <a href='"+submission_url+"'>"+self.id+"</a><br>\n"
    output += "Submitted: "+self.created_at.to_s(:default)+"<br>\n"
    output +="<table>"
    for key in self.content.keys
      output +="<tr><td><b>"+key+"</b></td><td>"+ self.content[key]+"</td></tr>"
    end
    output +="</table>"
    output
  end

  def as_string
    output = ""
    output += "ID: "+self.id+"\n"
    output += "Submitted: "+self.created_at.to_s(:default)+"\n"

    for key in self.content.keys
      output +=key+": "+ self.content[key]+"\n"
    end
    output
  end

end