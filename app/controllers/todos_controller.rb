class TodosController < ApplicationController
  def index
    render json: Todo.all
  end

  def update
    todo = Todo.find(params[:id])
    todo.update_attributes(todo_params) 
    render json: todo
  end

  def create
    todo = Todo.create(todo_params)
    render json: todo
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
  end

  private
  def todo_params
    params[:todo].permit(:title, :is_completed)
  end
end

