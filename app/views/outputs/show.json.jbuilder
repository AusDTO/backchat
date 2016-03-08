json.(@form, :id,:name,:website,:created_at, :updated_at)

json.array! @form, input_fields

json.(@form, :satisfaction_avg,:submissions_count)