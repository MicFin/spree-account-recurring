module Spree
  class Recurring < ActiveRecord::Base
    include RestrictiveDestroyer

    acts_as_restrictive_destroyer

    preference :secret_key, :string
    preference :public_key, :string

    has_many :plans
    attr_readonly :type
    validates :type, :name, presence: true
    scope :active, -> { undeleted.where(active: true) }

    def self.display_name
      name.gsub(%r{.+:}, '')
    end

    def visible?
      active? && !is_destroyed?
    end

    def default_plan
      plans.default
    end
  end
end