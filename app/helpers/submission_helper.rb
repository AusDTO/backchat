module SubmissionHelper
  def submission_path(submission)
    '/submission/'+submission.id
  end
end
