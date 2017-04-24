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

  belongs_to :app, optional: true

  before_save :titleize_title

  validates :title, presence: true, uniqueness: true

  private
  def titleize_title
    self.title = self.title.titleize
  end

end
