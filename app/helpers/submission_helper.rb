module SubmissionHelper
  def submission_path(submission)
    '/submission/'+submission.id
  end
  def submission_url(submission)
    "https://"+APP_CONFIG["app_domain"] +submission_path(submission)
  end
end
