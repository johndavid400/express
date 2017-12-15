class User
  # create some methods to override in host application
  attr_accessor :id

  def initiate
    @id = nil
  end

  def can_manage?(site)
    true
  end

  def can_manage_api?
    true
  end

  def sites
    Site.all
  end

end
