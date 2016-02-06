class FormDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [Form.id]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [Form.name]
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
          Form.id,
          Form.name,
          Form.updated_at
      ]
    end
  end

  def get_raw_records
    Form.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
