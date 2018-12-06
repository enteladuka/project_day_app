json.extract! task_entry, :id, :note, :duration, :task_id, :created_at, :updated_at
json.url task_entry_url(task_entry, format: :json)
