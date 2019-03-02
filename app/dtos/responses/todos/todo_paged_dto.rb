class TodoPagedDto < BasePagedDto
  def initialize(todos, page_meta)
    super(page_meta)
    @todos = todos
  end

  def self.build(todos, todos_count, path, page, page_size)
    todo_dtos = []
    todos.each do |todo|
      todo_dtos.append TodoDto.build todo, false
    end
    TodoPagedDto.new todo_dtos, PageMeta.build(todos, todos_count, path, page, page_size)
  end
end