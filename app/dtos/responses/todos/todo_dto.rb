class TodoDto

  def self.build(todo, include_description = false)
    result = {}
    result[:id] = todo.id
    result[:title] = todo.title
    result[:completed] = todo.completed
    if include_description
      result[:description] = todo.description
    end
    result[:created_at] = todo.created_at
    result[:updated_at] = todo.updated_at
    result
  end
end