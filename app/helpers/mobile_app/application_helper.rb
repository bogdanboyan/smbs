module MobileApp::ApplicationHelper
  
  def compress_css(source)
    source.gsub!(/\s+/, " ")
    source.gsub!(/\/\*(.*?)\*\//, "")
    source.gsub!(/\} /, "}\n")
    source.gsub!(/\n$/, "")
    source.gsub!(/ \{ /, " {")
    source.gsub!(/; \}/, "}")
    source
  end
  
end
