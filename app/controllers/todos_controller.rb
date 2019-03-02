class TodosController < ApplicationController
  before_action :set_page, only: [:index, :get_pending, :get_completed]
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    dto = get_todo_list_dto Todo
    render json: dto, status: :ok
  end

  def get_pending
    dto = get_todo_list_dto Todo.where(completed: false)
    render json: dto, status: :ok
  end

  def get_completed
    dto = get_todo_list_dto Todo.where(completed: true)
    render json: dto, status: :ok
  end

  # GET /todos/1
  def show
    dto = TodoDetailsDto.build @todo
    render json: dto, status: :ok
  end

  # POST /todos
  def create
    todo = Todo.new(todo_params)
    if todo.save
      dto = TodoDetailsDto.build todo, 'Todo created successfully'
      render json: dto, status: :ok
    else
      dto = ErrorResponseDto.new 'Something went wrong'
      render json: dto, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      dto = TodoDetailsDto.build @todo, 'Todo updated successfully'
      render json: dto, status: :ok
    else
      dto = ErrorResponseDto.new 'Something went wrong'
      render json: dto, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
    dto = SuccessResponseDto.new 'Deleted successfully'
    render json: dto, status: :unprocessable_entity
  end

  def destroy_all
    # delete_all vs destroy_all? delete skips callbacks, destroy does execute them
    # destroy deletes the object and associated objects(not used in this project)
    # delete will only delete the current object,no the associated models
    Todo.destroy_all
    dto = SuccessResponseDto.new 'Deleted all todos successfully'
    render json: dto, status: :unprocessable_entity
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end

  def get_todo_list_dto(query)
    todos = query.order(created_at: :desc).offset(@offset).limit(@page_size).select("id, title,completed, created_at, updated_at")
    todos_count = query.count

    # either one works, this is to show you that you can use both approaches, hash based, or object based
    # TodoPagedDto.build todos, todos_count, self.request.path, @page, @page_size
    TodoListDto.build todos, todos_count, self.request.path, @page, @page_size
  end

  def set_page
    @page = params[:page] || 1
    @page_size = params[:page_size] || 8
    @offset = @page_size * (@page - 1)
  end

  # Only allow a trusted parameter "white list" through.
  def todo_params
    params.permit(:title, :description, :completed)
  end
end
