require 'elasticsearch/model'

module SearchableTenanted
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name "#{Rails.env}-#{Apartment::Tenant.current}-#{self.name.underscore}"

  end
end
