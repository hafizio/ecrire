#encoding: utf-8

module BlogHelper
  def root?
    current_page? :root
  end

end
