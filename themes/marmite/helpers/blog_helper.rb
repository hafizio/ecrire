module BlogHelper
  def root?
    current_page? :root
  end
end
