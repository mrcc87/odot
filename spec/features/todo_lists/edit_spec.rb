require 'spec_helper.rb'

describe "Edit todo lists" do

  let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery List.") }

  # method for updating a todo list
  def update_todo_list(options={})

    options[:title] ||= "New title"
    options[:description] ||= "New description"
    todo_list = options[:todo_list]

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"

  end

  # first test
  it "updates a todo list successfully with correct information" do

    update_todo_list todo_list: todo_list

    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated")
    expect(todo_list.title).to eq("New title")
    expect(todo_list.description).to eq("New description")
  end

 # second test
  it "displays and error with no title" do
    update_todo_list todo_list: todo_list, title: ""
    title = todo_list.title #title in memory
    todo_list.reload
    expect(todo_list.title).to eq(title) #title in memory should be the same as in db as it was not updated
    expect(page).to have_content("error")
  end

  # third test
  it "displays and error with too short a title" do
    update_todo_list todo_list: todo_list, title: "Hi"
    title = todo_list.title #title in memory
    todo_list.reload
    expect(todo_list.title).to eq(title) #title in memory should be the same as in db as it was not updated
    expect(page).to have_content("error")
  end

 # forth test
  it "displays and error with no description" do
    update_todo_list todo_list: todo_list, description: ""
    description = todo_list.description #description in memory
    todo_list.reload
    expect(todo_list.description).to eq(description) #description in memory should be the same as in db as it was not updated
    expect(page).to have_content("error")
  end

  # fifth test
  it "displays and error with too short a description" do
    update_todo_list todo_list: todo_list, description: "Ciao"
    description = todo_list.description #description in memory
    todo_list.reload
    expect(todo_list.description).to eq(description) #description in memory should be the same as in db as it was not updated
    expect(page).to have_content("error")
  end

end
