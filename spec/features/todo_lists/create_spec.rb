require 'spec_helper'

describe "Creating todo lists" do

  # method that creates a new todo list
  def create_todo_list(options={})
    options[:title] ||= "My todo list" # default title if none is provided
    options[:description] ||= "This is my todo list" # default description if none is provided

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

  # first test
  it "redirects to the todo list index page on success" do
    create_todo_list
    expect(page).to have_content("My todo list")
  end

  # second test
  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: ""
    
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is my todo list")

  end

  # third test
  it "displays an error when the todo list title has less than 3 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "Hi"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is my todo list")

  end

  # forth test
  it "displays an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "Grocery List", description: ""
   
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Grocery List")

  end

  # fifth test
  it "displays an error when the todo list description has less than 5 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "Grocery List", description: "Ciao"
   
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Grocery List")

  end

end
