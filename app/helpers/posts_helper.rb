module PostsHelper
  def to_cover(src)
    src.gsub('w=1200', 'w=300').gsub('h=627', 'h=157')
  end
end
