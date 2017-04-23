# == Schema Information
#
# Table name: apps
#
#  id          :integer          not null, primary key
#  name        :string
#  platform_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class App < ApplicationRecord
  resourcify
  belongs_to :platform

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

end
