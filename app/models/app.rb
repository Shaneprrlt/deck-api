# == Schema Information
#
# Table name: apps
#
#  id          :integer          not null, primary key
#  name        :string
#  platform_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  removed     :boolean          default(FALSE), not null
#

class App < ApplicationRecord
  resourcify
  belongs_to :platform

  after_save :update_label

  def contributors
    applied_roles.map do |r|
      if r.name.downcase === "contributor"
        r.users[0]
      end
    end
  end

  def clear_contributors
    contributors.each do |u|
      u.remove_role(:contributor, self)
    end

    self
  end

  private
  def update_label
    label = Label.where(app: self).first_or_create
    label.update(title: self.name)
  end

end
