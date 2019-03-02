class BasePagedDto < SuccessResponseDto

  attr_accessor :page_meta

  def initialize(page_meta)
    super(true)
    @page_meta = page_meta
  end

end