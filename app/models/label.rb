# == Schema Information
#
# Table name: labels
#
#  id         :integer          not null, primary key
#  title      :string
#  app_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Label < ApplicationRecord
  include SearchableTenanted

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english'
    end
  end

  self.per_page = 50

  belongs_to :app, optional: true

  before_validation :titleize_title

  validates :title, presence: true, uniqueness: true

  private
  def titleize_title
    self.title = self.title.titleize if self.title.present?
  end

end
