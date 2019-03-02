class TodoListDto

  def self.build(todos, todos_count, path, page, page_size)
    todo_dtos = []
    todos.each do |todo|
      todo_dtos.append TodoDto.build todo, false
    end
    {success: true, page_meta: PageMeta.build(todos, todos_count, path, page, page_size), todos: todo_dtos}
  end
end