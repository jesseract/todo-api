require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  let(:todo_json) { JSON.parse(response.body) }

  before do 
    5.times do |i|
      Todo.create(
        title: "Todo #{i}",
        is_completed: false
      )
    end 
  end 

  subject { Todo.first }

  describe 'GET: /todos' do
    it "returns the title" do
      get :index
      ap todo_json
      expect(todo_json["todos"].length).to eq 5

    end
    it "returns five todos" 
      
      
    it "returns the is_completed"
  end

  describe 'PUT: /todos/:id' do
    it "will let you update the title"
    it "will let you change is_completed"
  end

  describe 'POST: /todos' do
    it "will let you set the title"
    it "will default the is_completed to false"
  end

  describe 'DELETE: /todos/:id' do
    it "will delete the todo with a given id"
  end
end
