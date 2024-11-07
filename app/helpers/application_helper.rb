module ApplicationHelper
  def active_if(controller, action)
    controller == controller_path && action == action_name ? 'active' : ''
  end
end
