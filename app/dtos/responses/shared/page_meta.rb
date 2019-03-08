class PageMeta
  def initialize

  end

  def self.build(collection, total_items_count, base_path, page, page_size)
    offset = (page - 1) * page_size
    requested_page_size = page_size
    current_items_count = collection.size
    total_items_count = total_items_count
    current_page_number = page
    # Force the result of / to be float, with one .to_f is enough
    number_of_pages = (total_items_count.to_f / page_size.to_f).ceil

    if number_of_pages > current_page_number
      has_next_page = true
    else
      has_next_page = false
    end
    if current_page_number <= 1
      has_prev_page = false
    else
      has_prev_page = true
    end

    if has_next_page
      next_page_number = current_page_number + 1
      next_page_url = format("%s?page_size=%d&page=%d", base_path, page_size, current_page_number + 1)
    else
      next_page_number = current_page_number
      next_page_url = format("%s?page_size=%d&page=%d", base_path, page_size, current_page_number)
    end

    if has_prev_page
      prev_page_number = current_page_number - 1
      prev_page_url = format("%s?page_size=%d&page=%d", base_path, page_size, current_page_number - 1)
    else
      prev_page_number = current_page_number
      prev_page_url = format("%s?page_size=%d&page=%d", base_path, page_size, current_page_number)
    end

    {offset: offset, requested_page_size: requested_page_size, current_items_count: current_items_count,
     total_items_count: total_items_count, current_page_number: current_page_number, number_of_pages: number_of_pages, has_next_page: has_next_page,
     has_prev_page: has_prev_page, next_page_number: next_page_number, next_page_url: next_page_url,
     prev_page_number: prev_page_number, prev_page_url: prev_page_url}
  end

end
