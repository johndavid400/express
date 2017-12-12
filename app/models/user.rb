class User

  def initiate
  end

  def can_manage?(site)
    true
  end

  def sites
    Site.all
  end

end
