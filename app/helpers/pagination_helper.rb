# encoding: utf-8
module PaginationHelper
  
  %w(details campaigns shorteners barcodes).each do |namespace|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      class #{namespace.humanize}LinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
        def url(number)
          "%s?page=%s" % ['#{namespace}', number]
        end
      end
    RUBY_EVAL
  end
  
  
  def paginate(collection, options={})
    will_paginate(collection, options.merge({
      :previous_label    =>    (options[:previous_label] || 'Предыдущая'),
      :next_label        =>    (options[:next_label]     || 'Следующая'),
      :class             =>    (options[:class]          || 'mod pagination'),
    }))
  end
  
end
