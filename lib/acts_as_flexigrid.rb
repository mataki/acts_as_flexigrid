require "acts_as_flexigrid/version"
require "active_support/concern"

module ActsAsFlexigrid
  extend ActiveSupport::Concern

  included do
    scope :flexigrid_scope, lambda { |params|
      page(params["page"]).per(params["rp"]).flexigrid_order(params["sortname"], params["sortorder"]).flexigrid_where(params["qtype"], params["query"])
    }

    scope :flexigrid_where, lambda { |type, query|
      if type and type.strip.present? and query and query.strip.present?
        method_name = "#{type}_flexigrid_where"
        if self.respond_to?(method_name)
          self.send(method_name, query)
        else
          any_flexigrid_where(type, query)
        end
      end
    }

    scope :any_flexigrid_where, lambda { |type, query|
      where("#{quoted_table_name}.#{connection.quote_column_name(type.strip)} LIKE :val", {:val => "%#{query.strip}%"})
    }

    scope :flexigrid_order, lambda { |name, order|
      if name.present? and order.present?
        order = order.downcase == "asc" ? "asc" : "desc"
        order("#{quoted_table_name}.#{connection.quote_column_name(name.strip)} #{order}")
      end
    }
  end

  module ClassMethods
    def flexigrid(params, options = {}, &block)
      rows = flexigrid_scope(params).map do |site|
        cell = site.attributes.merge(options)
        cell.merge!(yield(site)) if block_given?
        { :id => site.id, :cell => cell }
      end
      { :rows => rows, :total => self.flexigrid_where(params['qtype'], params['query']).count, :page => params["page"] }
    end
  end
end
