module TodoListHelpers
  # method that visits a todo list items page
  def visit_todo_list list
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end
  end

end
