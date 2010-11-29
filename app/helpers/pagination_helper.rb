# encoding: utf-8
module PaginationHelper
  
  class StatisticLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
    def url(number)
      "details?page=#{number}"
    end
  end
  
  def paginate(collection, options={})
    will_paginate(collection, options.merge({
      :previous_label    =>    (options[:previous_label] || 'Предыдущая'),
      :next_label        =>    (options[:next_label]     || 'Следующая'),
      :class             =>    (options[:class]          || 'mod pagination'),
    }))
  end
  
end
