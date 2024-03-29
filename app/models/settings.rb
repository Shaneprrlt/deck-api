# == Schema Information
#
# Table name: public.settings
#
#  id         :integer          not null, primary key
#  var        :string           not null
#  value      :text
#  thing_id   :integer
#  thing_type :string(30)
#  created_at :datetime
#  updated_at :datetime
#

# RailsSettings Model
class Settings < RailsSettings::Base
  source Rails.root.join("config/app.yml")
  namespace Rails.env


end
