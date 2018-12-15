class TaskEntry < ApplicationRecord
  belongs_to :task



  def time_lapsed
    duration = (Time.now - task_entry.created_at).to_i
    hours = (duration/ 3600).to_i
    minutes = ((duration % 3600) / 60).to_i
    seconds = ((duration % 3600) % 60).to_i
  end
end

#elapsed_seconds = ((end_time - start_time) * 24 * 60 * 60).to_i
#could execute a while loop (like
 #while created_at == updated_at,)
 # duration = Time.now-created_at
#end
