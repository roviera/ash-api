# == Schema Information
#
# Table name: adopters
#
#  id                :integer          not null, primary key
#  first_name        :string           not null
#  last_name         :string           not null
#  ci                :string           not null
#  email             :string           default("")
#  phone             :string           not null
#  house_description :string           default("")
#  blacklisted       :boolean          default("false"), not null
#  home_address      :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Adopter < ActiveRecord::Base
  include SearchableAdopters
  validates :ci, uniqueness: true
  validates :first_name, :last_name, :ci, :home_address, presence: true
  validates :first_name, :last_name, length: { maximum: 30 }
  validates :phone, presence: true, format: { with: /\A[0-9]{8}[0-9]?\z/ }
end