require 'spec_helper'

describe "Adding todo items" do
  let!(:todo_list) { TodoList.create(title: "Groceries List", description: "My Grocery List.")}

  # method that visits a todo list items page
  def visit_todo_list list
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end
  end

  it "is going to be successful with valid content" do
    visit_todo_list todo_list
    click_link "New Todo Item"
    fill_in "Content", with: "Milk"
    click_button "Save"
    expect(page).to have_content("Added todo list item.")
    within("ul.todo_items") do
      expect(page).to have_content("Milk")
    end
  end


end
