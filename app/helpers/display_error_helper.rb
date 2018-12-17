module DisplayErrorHelper
  def display_error(object, field)
    if object.errors[field].any?
        raw "<div class = 'alert alert-danger'>"+object.errors[field].first+"<br>"+"</div>"
    end
  end
end
