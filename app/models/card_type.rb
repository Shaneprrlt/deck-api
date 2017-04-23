# == Schema Information
#
# Table name: public.card_types
#
#  id         :integer          not null, primary key
#  name       :string
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CardType < ApplicationRecord
end
