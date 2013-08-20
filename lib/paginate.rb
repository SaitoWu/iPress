module Mongoid
  module Paginate
    extend ActiveSupport::Concern

    included do
      cattr_accessor :per_page
      self.per_page = 20
    end

    module ClassMethods
      def paginate(opts = {})
        opts ||= {}
        puts "------ opts : #{opts}"
        self.per_page = opts[:per_page] if opts[:per_page]
        self.scope :paginate, ->(opts) {
          opts[:page] ||= 1
          limit(self.per_page).skip([0,(opts[:page].to_i - 1) * self.per_page].max)
        }
      end

      def total_pages
        (self.count / self.per_page.to_f).ceil
      end
    end
  end
end
