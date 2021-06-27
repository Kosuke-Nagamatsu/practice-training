module ApplicationHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'create' || action_name == 'confirm'
      confirm_tasks_path
    elsif action_name == 'edit'
      task_path
    end
  end
end
