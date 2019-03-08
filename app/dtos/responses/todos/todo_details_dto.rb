class TodoDetailsDto
  def self.build(todo, messages = nil)
    dto = TodoDto.build todo, true
    dto[:success] = true
    if not messages.nil?
      if messages.instance_of? String
        dto[:full_messages] = [messages]
      elsif messages.instance_of? Array
        dto[:full_messages] = messages
      end
    else
      dto[:full_messages] = []
    end
    dto
  end
end