module PostsHelper
  def to_cover(src)
    src.gsub('w=1200', 'w=300').gsub('h=627', 'h=157')
  end

  def default_cover
    'https://images.pexels.com/photos/567985/pexels-photo-567985.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=157&w=300'
  end
end
