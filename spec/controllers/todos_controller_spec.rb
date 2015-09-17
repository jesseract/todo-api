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
      expect(todo_json["todos"].first["title"]).to eq "Todo 0" 
    end

    it "returns five todos"  do
      get :index
      expect(todo_json["todos"].length).to eq 5
    end
      
    it "returns the is_completed" do
      get :index
      expect(todo_json["todos"].first["is_completed"]).to eq false 
    end
  end

  describe 'PUT: /todos/:id' do
    let(:json) {
      {
        "title" => "Profit!",
        "is_completed" => true
      }
    }

    it "will let you update the title" do
      expect{
        put :update, id: subject.id, todo: json
      }.to change{ subject.reload.title }
      expect(todo_json['todo']).to eq json.merge({'id' => subject.id})
    end

    it "will let you change is_completed" do
      expect{
        put :update, id: subject.id, todo: json
      }.to change{ subject.reload.is_completed }
      expect(todo_json['todo']).to eq json.merge({'id' => subject.id})
    end
  end

  describe 'POST: /todos' do
    let(:json) {
      {
        "title" => "Test 2",
        "is_completed" => false
      }
    }

    it "will create a new todo" do
      expect{
        post :create, todo: json
      }.to change{ Todo.count }.by(1)
      expect(todo_json['todo']['title']).to eq json['title']
      expect(todo_json['todo']['is_completed']).to eq json['is_completed']
    end

  end

  describe 'DELETE: /todos/:id' do
    it "will delete the todo with a given id" do
      expect{
        delete :destroy, id: Todo.first
      }.to change{ Todo.count }.by(-1)
    end
  end
end
