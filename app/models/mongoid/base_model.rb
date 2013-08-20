module Mongoid
  module BaseModel
    extend ActiveSupport::Concern

    included do
      include Mongoid::Document
      include Mongoid::Timestamps
      include Mongoid::Paginate

      scope :recent, desc(:_id)
      scope :exclude_ids, Proc.new { |ids| where(:_id.nin => ids.map(&:to_i)) }
    end
  end
end
